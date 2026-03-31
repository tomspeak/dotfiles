# Ensure homebrew is in PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

autoload -U colors && colors

# Fast git prompt
git_branch_prompt() {
  [[ -d .git ]] || git rev-parse --git-dir &>/dev/null || return

  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
  [[ "$branch" == "HEAD" ]] && branch=$(git rev-parse --short HEAD 2>/dev/null)
  [[ -z $(git status --porcelain 2>/dev/null) ]] || branch="$branch*"
  echo " ($branch)"
}

setopt prompt_subst
NEWLINE=$'\n'
PS1="%(?.%F{green}.%F{red})[clown@"
if [[ -n "$SSH_CONNECTION" ]]; then
  PS1+="${SSH_CONNECTION%% *}"
else
  PS1+="local"
fi
PS1+="] %~\$(git_branch_prompt)%f$NEWLINE >> "

# Prepend custom paths to existing PATH (preserves homebrew etc)
# Use $path array to manipulate, then export
path=(
  /usr/local/bin
  /usr/local/sbin
  ~/.composer/vendor/bin
  "$HOME/.bin"
  ~/.local/bin
  ~/workspace/zig/zls/zig-out/bin
  "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
  "$HOME/.opencode/bin"
  $path
)
typeset -U PATH

export TZ="Europe/London"
export MANPAGER='nvim +Man!'
export DOTFILES="$HOME/dotfiles"
export PAGER='less'
export GIT_MERGE_AUTOEDIT=no
export EDITOR='nvim'
export VEDITOR='code'

setopt AUTO_CD              # Go to folder path without using cd.
setopt AUTO_PUSHD           # Push directories onto the stack.
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates.
setopt PUSHD_SILENT         # Don't print the stack after pushd/popd.

bindkey '^f' autosuggest-accept

# Lazy load completions on first tab press
_setup_completions() {
  autoload -Uz compinit
  compinit -C

  zstyle ':completion:*' completer _extensions _complete _approximate
  zstyle ':completion:*' menu select
  zstyle ':completion:*' use-cache true
  zstyle ':completion:*' rehash false

  # Rebind to normal completion
  bindkey '^I' expand-or-complete
  unfunction _setup_completions
}

# Custom widget to load completions on first use
_load_and_complete() {
  _setup_completions
  zle expand-or-complete
}
zle -N _load_and_complete
bindkey '^I' _load_and_complete

# Tab completion
bindkey '^[[3~' delete-char  # Delete
bindkey '^[[Z' reverse-menu-complete  # Shift+Tab
bindkey '^[[1;5D' backward-word  # Control-Left
bindkey '^[[1;5C' forward-word  # Control-Right

# History settings
HISTFILE=$HOME/.zhistory
HISTSIZE=20000
SAVEHIST=20000
setopt EXTENDED_HISTORY       # Record timestamp in history.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Dont write duplicate entries in the history file.
setopt SHARE_HISTORY          # Share history between all sessions.
unsetopt HIST_VERIFY          # Execute commands using history (e.g.: using !$) immediately
unsetopt correct

source "$HOME/dotfiles/shell/functions"
source "$HOME/dotfiles/shell/aliases"

if [[ -f "$HOME/dotfiles/shell/work" ]]; then
  source "$HOME/dotfiles/shell/work"
fi

# Load autosuggestions with optimizations
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true
autosuggest_path="/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -f "$autosuggest_path" ]]; then
  source "$autosuggest_path"
fi

# Load FZF
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  source <(fzf --zsh)
fi
