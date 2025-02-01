source ~/.config/fish/aliases.fish
if test -f ~/.config/fish/work.fish
  source ~/.config/fish/work.fish
end

theme_gruvbox dark medium

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
    set -l cwd (prompt_pwd)

    set -l cyan (set_color -o cyan)
    set -l normal (set_color normal)

    set -l time (date '+%I:%M:%S')
    set -l cwd (basename (prompt_pwd))

    set_color black -b cyan
    echo -n " $time "

    set_color black -b blue
    echo -n " $cwd "

    # Show git branch and dirty state
    set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    set -l git_dirty (command git status -s --ignore-submodules=dirty 2> /dev/null)
    if test -n "$git_branch"
        if test -n "$git_dirty"
            set_color black -b yellow
            echo -n " $git_branch "
        else
            set_color black -b green
            echo -n " $git_branch "
        end
    end

    # Add a space
    set_color normal
    echo -n ' '
end
