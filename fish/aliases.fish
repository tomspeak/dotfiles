function tat
  tmux -u new-session -As (basename $PWD)
end
alias tl="tmux ls"
alias ta="tmux attach -t"
alias tk="tmux kill-session -t"
alias td="tmux detach"

alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"

alias n='nvim'

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
