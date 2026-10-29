#!/bin/bash
# Run from the repository root; uses only a disposable tmux server.
set -euo pipefail

name="nvim-zen-test-$$"
trap 'tmux -L "$name" kill-server 2>/dev/null || true' EXIT
tmux -L "$name" -f /dev/null new-session -d -s zen-test 'sleep 30'
tmux -L "$name" split-window -d -t zen-test 'sleep 30'
tmux -L "$name" set-option -t zen-test status 2
tmux -L "$name" set-option -w -t zen-test pane-border-status top
socket="$(tmux -L "$name" display-message -p '#{socket_path},#{pid},0')"
pane="$(tmux -L "$name" display-message -p -t zen-test '#{pane_id}')"

TMUX="$socket" TMUX_PANE="$pane" nvim --headless -i NONE -c "lua dofile('tests/nvim/zen-tmux.lua')"
