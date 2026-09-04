# me, myself & Я

On Apple Silicon macOS, run `./scripts/setup.sh` to install dependencies,
Neovim nightly, and configuration symlinks. If prompted to install Xcode command
line tools, finish that installation and run setup again.
Conflicting existing configurations are saved beside their destinations in
`*.backup.*/original`; running setup again preserves links already in place.
Use `nnu` to update nightly; the previous build remains available at
`~/.nvim-nightly/previous/bin/nvim` until the next successful update.
GitHub repositories use SSH in the Git config, so configure GitHub SSH access
before installing Neovim or tmux plugins; the TPM bootstrap itself uses HTTPS.

Install optional GUI applications with `./scripts/brew.sh --apps` after core
setup. These live in `Brewfile.apps` and do not gate the command-line toolchain.

Run `./scripts/preferences.sh` separately to apply desktop preferences, including
the sparse Dock layout. It restarts Dock, Finder, and SystemUIServer; reopen other
applications to apply their settings.
