DIR=/Users/t/dotfiles

all:
	@echo "Run things individually!"

symlinks:
	@ln -sf $(DIR)/zsh/zshrc ~/.zshrc
	@ln -nsf $(DIR)/vim/vim ~/.vim
	@ln -sf $(DIR)/vim/vimrc ~/.vimrc
	@ln -nsf $(DIR)/vim/plugin ~/.vim/plugin
	@ln -nsf $(DIR)/applescripts ~/.applescripts
	@ln -sf $(DIR)/tmux/tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/tmux/theme.sh ~/.tmux/theme.sh
	@ln -sf $(DIR)/ag/agignore ~/.agignore
	@ln -sf $(DIR)/ack/ackrc ~/.akrc
	@ln -sf $(DIR)/git/gitconfig ~/.gitconfig
	@ln -sf $(DIR)/git/gitignore_global ~/.gitignore_global
	@ln -sf $(DIR)/bin ~/.bin
	@ln -sf $(DIR)/npmrc/npmrc ~/.npmrc
	@ln -sf $(DIR)/nvchad/custom ~/.config/nvim/lua/
	@ln -sf $(DIR)/kitty ~/.config
	@ln -sf $(DIR)/karabiner ~/.config
	@ln -sf $(DIR)/starship.toml ~/.config

install_ohmyzsh:
	./scripts/install_oh_my_zsh.sh

install_brews:
	brew tap Homebrew/bundle
	brew tap caskroom/versions
	brew bundle

tmux_plugins:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

term_info:
	tic term-config/xterm-256color-italic.terminfo
	tic -x term-config/tmux-256color.terminfo
