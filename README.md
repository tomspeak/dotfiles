# me, myself & Я

Fresh Apple Silicon Mac, starting in Terminal:

1. Run `xcode-select --install` and finish the installation before continuing.

2. Clone and run setup (installs Homebrew tools, asdf Node, Neovim nightly, and config links):

   ```sh
   git clone https://github.com/tomspeak/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ./scripts/setup.sh
   ```

3. Open a new Terminal window to load the configured shell.

4. Optional desktop apps: run `~/dotfiles/scripts/brew.sh --apps`.
   Install [Ghostty tip](https://github.com/ghostty-org/ghostty/releases/tag/tip) (`Ghostty.dmg`) and your Berkeley Mono / Monaspace Neon NF fonts.
   Open Hammerspoon and Karabiner and grant their requested permissions.

5. Configure [GitHub SSH access](https://docs.github.com/en/authentication/connecting-to-github-with-ssh); the Git config uses SSH for plugin downloads.

6. Start `nvim` and let plugins install. Start `tmux`, then press `Ctrl+a` followed by `Shift+i` to install its plugins.

7. Optional macOS preferences: **review** `~/dotfiles/scripts/preferences.sh` before running it—it changes Dock and power settings.

Existing configs are backed up beside their destinations as `*.backup.*/original`.

Updates: `nnu` for Neovim. For Node, change `.tool-versions`, then run `~/dotfiles/npm/install.sh`.
