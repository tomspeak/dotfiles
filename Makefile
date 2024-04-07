DIR=/Users/t/dotfiles

all:
	@echo "Run things individually!"

symlinks:
	@ln -sf $(DIR)/zsh/zshrc ~/.zshrc
	@ln -nsf $(DIR)/applescripts ~/.applescripts
	@ln -sf $(DIR)/tmux/tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/tmux/theme.sh ~/.tmux/theme.sh
	@ln -sf $(DIR)/git/gitconfig ~/.gitconfig
	@ln -sf $(DIR)/git/gitignore_global ~/.gitignore_global
	@ln -sf $(DIR)/nvim/ ~/.config/nvim/
	@ln -sf $(DIR)/karabiner ~/.config
	@ln -sf $(DIR)/starship.toml ~/.config
	@ln -sf $(DIR)/ghostty ~/.config
	@ln -sf $(DIR)/spacebar ~/.config/
	@ln -sf $(DIR)/skhdrc ~/.config/
	@mkdir -p ~/Library/KeyBindings/
	@ln -sf $(DIR)/DefaultKeyBinding.dict ~/Library/KeyBindings/

install_ohmyzsh:
	./scripts/install_oh_my_zsh.sh

install_brews:
	brew tap Homebrew/bundle
	brew tap caskroom/versions
	brew tap caskroom/cask
	brew bundle

tmux_plugins:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
