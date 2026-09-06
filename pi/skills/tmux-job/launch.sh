#!/bin/bash
set -euo pipefail
umask 077

if [[ $# != 2 || -z "$2" || -z "${TMUX:-}" || -z "${TMUX_PANE:-}" ]]; then
  echo "Usage (inside tmux): bash launch.sh CWD 'shell command'" >&2
  exit 2
fi
cd -- "$1"
cwd=$(pwd -P)
session=$(tmux display-message -p -t "$TMUX_PANE" '#{session_id}')
socket=$(tmux display-message -p -t "$TMUX_PANE" '#{socket_path}')
root="${XDG_STATE_HOME:-$HOME/.local/state}/pi/jobs"
mkdir -p "$root"
root=$(cd "$root" && pwd -P)
job=$(mktemp -d "$root/job.XXXXXXXX")
printf '%s\n' "$2" > "$job/command.sh"
: > "$job/output.log"
gate="${job##*/}-start"
pane=''
trap 'if [[ -n "$pane" ]]; then tmux -S "$socket" kill-pane -t "$pane" 2>/dev/null || true; fi; echo "Launch incomplete; inspect $job before retrying." >&2' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# Gate the command until logging, identity and retention are ready.
# shellcheck disable=SC2016 # Variables belong to the pane's shell.
pane=$(tmux -S "$socket" new-window -d -P -F '#{pane_id}' -t "$session:" \
  -n "${job##*/}" -c "$cwd" -e "PATH=$PATH" /bin/bash -c '
    umask 077
    tmux wait-for "$1" || exit 125
    /bin/bash -o pipefail "$2/command.sh"
    code=$?
    { printf "%s\n" "$code" > "$2/exit.tmp" && mv "$2/exit.tmp" "$2/exit"; } || exit 125
    exit "$code"
  ' -- "$gate" "$job")
tmux -S "$socket" set-option -p -t "$pane" remain-on-exit on
tmux -S "$socket" set-option -p -t "$pane" @pi_job "$job"
# ponytail: logs grow until cleanup; add rotation for noisy unattended watchers.
printf -v pipe_command 'exec cat >> %q' "$job/output.log"
tmux -S "$socket" pipe-pane -O -t "$pane" "${pipe_command//#/##}"
jq -n --arg cwd "$cwd" --arg socket "$socket" --arg session "$session" --arg pane "$pane" --arg owner "${PI_SESSION_ID:-}" \
  '{cwd: $cwd, socket: $socket, session: $session, pane: $pane, owner: $owner}' > "$job/job.json"
tmux -S "$socket" wait-for -S "$gate"
trap - EXIT INT TERM
printf '%s\n' "$job"
