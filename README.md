# dotfiles

### Installation

1. `git clone git@github.com:tomspeak/dotfiles.git ~/dotfiles`
2. `cd ~/dotfiles`
3. `make install_brews`
4. `make install_ohmyzsh`
5. `rm -rf ~/.zshrc`
6. `mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc`
7. `make install_vundle`
8. `make tmux_plugins`
9. `make term_info`
10. `make symlinks`
11. `zplug install`
