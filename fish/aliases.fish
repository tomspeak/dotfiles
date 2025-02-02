function tat
  tmux -u new-session -As (basename $PWD)
end
alias tl="tmux ls"
alias ta="tmux attach -t"
alias tk="tmux kill-session -t"
alias td="tmux detach"

alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"

alias n='nvim'

alias hs='history | grep'

#laravel
alias a="php artisan"
alias af="php artisan migrate:fresh && php artisan db:seed"
alias al="php artisan list"
alias aq="php artisan queue:work"
alias at="php artisan test"
alias atink="php artisan tinker"

#composer
alias c="composer"
alias ci="composer install"
alias cr="composer require"
alias crd="composer require --dev"

function yta
  yt-dlp -f bestaudio --audio-format m4a --embed-thumbnail --add-metadata --metadata-from-title "%(title)s" --output "%(title)s.%(ext)s" -x $argv[1]
end

function mkcd
  mkdir -p $argv[1] && cd $argv[1]
end

function gif
  ffmpeg -i $argv[1] -vf fps=5,scale=480:-1,smartblur=ls=-0.5 $argv[2]
end
