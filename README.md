# me, myself & Я

On Apple Silicon macOS, run `./scripts/setup.sh` to install dependencies,
Neovim nightly, and configuration symlinks. If prompted to install Xcode command
line tools, finish that installation and run setup again.
Conflicting existing configurations are saved beside their destinations in
`*.backup.*/original`; running setup again preserves links already in place.

Run `./scripts/preferences.sh` separately to apply desktop preferences, including
the sparse Dock layout. It restarts Dock, Finder, and SystemUIServer; reopen other
applications to apply their settings.
