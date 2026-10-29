# Neovim regression checks

Run from the repository root with the configured nightly and installed plugins:

```sh
nvim --headless -i NONE -c "lua dofile('tests/nvim/smoke.lua')"
nvim --clean --headless -l tests/nvim/zig-debug.lua
bash tests/nvim/zen-tmux.sh
```

- `smoke.lua`: syntax, native mappings, unchanged Mini completion, LSP overrides,
  Git commands/actions, explorer filters and bindings, and Zen window restoration.
  It uses temporary files and disables tmux integration in the test process.
- `zig-debug.lua`: async DAP protocol, project roots, executable selection,
  cancellation, build failures, and spawn errors. The process/UI are mocked; this
  does not compile a real Zig project or launch CodeLLDB.
- `zen-tmux.sh`: checks effective tmux status, pane-border, and zoom restoration
  using a disposable server, including a pane that was already zoomed.

All checks exit nonzero on failure. The smoke check can also be run with a candidate
nightly executable before switching `~/.bin/nvim` to it.

## Migration notes

- `-` toggles Snacks explorer; `_` reveals the current file. Explorer sidebars are
  per-tab rather than synchronized across tabs as in the previous NvimTree setup.
- `<leader>z` and `:ZenMode` use Snacks Zen.
- `ii`/`ai` and `[i`/`]i` retain indent-based scope behavior through Snacks.
- `Q`, `al`, and `il` are available for native multicursors and line text objects.
- `<leader>hs` stages/unstages the current hunk; `<leader>hp` previews it inline.
  The deprecated `<leader>hu` and `<leader>tD` bindings were removed.

### Upstream limitation

With Snacks revision `882c996cf28183f4d63640de0b4c02ec886d01f2`, immediately
closing an explorer while its finder is still loading can produce an async
`attempt to index field 'matcher' (a nil value)` error in Snacks' finder cleanup.
The smoke check waits for loading to finish before closing. No third-party
internals are patched by this config.
