#!/bin/bash
set -euo pipefail
umask 077

if [[ ( $# != 2 && $# != 3 ) || -z "$2" || -z "${TMUX:-}" || -z "${TMUX_PANE:-}" ]]; then
  echo "Usage (inside tmux): bash launch.sh CWD 'shell command' [description]" >&2
  exit 2
fi
description=${3-command}
if [[ ! "$description" =~ ^[a-zA-Z0-9][a-zA-Z0-9_-]{0,47}$ ]]; then
  echo "Description must be 1-48 letters, digits, underscores, or hyphens, starting with a letter or digit." >&2
  exit 2
fi
skill_dir=$(cd -- "$(dirname -- "$0")" && pwd)
cd -- "$1"
cwd=$(pwd -P)
session=$(tmux display-message -p -t "$TMUX_PANE" '#{session_id}')
socket=$(tmux display-message -p -t "$TMUX_PANE" '#{socket_path}')
root="${XDG_STATE_HOME:-$HOME/.local/state}/pi/jobs"
mkdir -p "$root"
root=$(cd "$root" && pwd -P)
# Serialize the layout snapshot and split across simultaneous launches.
exec 9>"$root/layout.lock"
flock -w 10 9 || { echo "Could not acquire the job layout lock." >&2; exit 1; }
tmux -S "$socket" source-file "$skill_dir/pane-titles.tmux"
geometry=$(tmux -S "$socket" display-message -p -t "$TMUX_PANE" \
  '#{pane_left} #{pane_top} #{pane_width} #{pane_height} #{window_zoomed_flag} #{pane-border-status}')
read -r host_left host_top host_width host_height zoomed border_status <<< "$geometry"
panes=$(tmux -S "$socket" list-panes -t "$TMUX_PANE" \
  -F '#{pane_id} #{pane_left} #{pane_top} #{pane_width} #{pane_height} #{@pi_job_parent}')
count=0
covered=-1
column_width=0
bottom=''
bottom_top=-1
bottom_height=0
column_valid=true
while read -r id left top width height parent; do
  [[ "$parent" == "$TMUX_PANE" ]] || continue
  if (( left != host_left + host_width + 1 || top < host_top ||
        top + height > host_top + host_height ||
        (column_width != 0 && width != column_width) )); then
    column_valid=false
  fi
  count=$((count + 1))
  covered=$((covered + height + 1))
  column_width=$width
  if (( top > bottom_top )); then
    bottom=$id
    bottom_top=$top
    bottom_height=$height
  fi
done <<< "$panes"

first_height=$host_height
if [[ "$border_status" == off ]]; then
  first_height=$((first_height - 1))
fi
create=(new-window -t "$session:" -n "job:$description")
if (( zoomed == 0 && count == 0 && host_width >= 40 && first_height >= 4 )); then
  create=(split-window -h -l 40% -t "$TMUX_PANE")
elif $column_valid && (( zoomed == 0 && count > 0 && covered == host_height &&
                        (host_height - count) / (count + 1) >= 4 )); then
  # Five rows allow a split even when pane-border-status is enabled.
  if (( count > 1 && bottom_height < 5 )); then
    tmux -S "$socket" resize-pane -t "$bottom" -y 5
  fi
  create=(split-window -v -l 1 -t "$bottom")
else
  echo "Job column unavailable or full; opening a separate window." >&2
fi
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
pane=$(tmux -S "$socket" "${create[@]}" -d -P -F '#{pane_id}' \
  -c "$cwd" -e "PATH=$PATH" /bin/bash -c '
    umask 077
    tmux wait-for "$1" || exit 125
    /bin/bash -o pipefail "$2/command.sh"
    code=$?
    { printf "%s\n" "$code" > "$2/exit.tmp" && mv "$2/exit.tmp" "$2/exit"; } || exit 125
    exit "$code"
  ' -- "$gate" "$job")
if [[ "${create[0]}" == split-window ]]; then
  tmux -S "$socket" set-option -p -t "$pane" @pi_job_parent "$TMUX_PANE"
  # The undersized new pane keeps -E from walking up into Pi's split.
  if (( count > 0 )); then
    tmux -S "$socket" select-layout -E -t "$pane"
  fi
else
  tmux -S "$socket" set-option -w -t "$pane" automatic-rename off
  tmux -S "$socket" set-option -w -t "$pane" allow-rename off
fi
tmux -S "$socket" select-pane -t "$pane" -T "job:$description"
tmux -S "$socket" set-option -p -t "$pane" remain-on-exit on
tmux -S "$socket" set-option -p -t "$pane" @pi_job "$job"
# The split hook runs before @pi_job exists, including in fallback windows.
tmux -S "$socket" set-option -w -t "$pane" pane-border-status top
# ponytail: logs grow until cleanup; add rotation for noisy unattended watchers.
printf -v pipe_command 'exec cat >> %q' "$job/output.log"
tmux -S "$socket" pipe-pane -O -t "$pane" "${pipe_command//#/##}"
jq -n --arg cwd "$cwd" --arg socket "$socket" --arg session "$session" --arg pane "$pane" --arg owner "${PI_SESSION_ID:-}" \
  '{cwd: $cwd, socket: $socket, session: $session, pane: $pane, owner: $owner}' > "$job/job.json"
tmux -S "$socket" wait-for -S "$gate"
trap - EXIT INT TERM
printf '%s\n' "$job"
