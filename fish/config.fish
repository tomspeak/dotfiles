source ~/.config/fish/aliases.fish
if test -f ~/.config/fish/work.fish
  source ~/.config/fish/work.fish
end

theme_gruvbox dark hard

set -x EDITOR 'nvim'
set -x VEDITOR 'code'

# hide vi mode 
function fish_mode_prompt; end

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showcolorhints 1
set __fish_git_prompt_char_dirtystate 'X'
set __fish_git_prompt_char_cleanstate 'OK'
set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_color_branch green
set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_color_dirtystate red

function fish_prompt
    if test -z "$SSH_CLIENT"
        set_color -o blue
    else
        set_color -o cyan
    end

    set_color --bold
    printf '%s' (pwd)
    set_color normal

    fish_git_prompt " %s"

    set_color normal

    echo ' '
end
