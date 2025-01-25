source ~/.config/fish/aliases.fish

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
    printf '%s' (prompt_pwd)
    set_color normal

    fish_git_prompt " %s"

    # if jobs -q
    #     set_color --bold red
    #     printf ' φ '
    # else
    #     set_color normal
    #     printf ' φ '
    # end
    printf ' '
    set_color normal

    echo
    echo -n ' '
end
