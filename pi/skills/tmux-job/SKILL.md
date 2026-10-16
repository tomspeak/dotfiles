---
name: tmux-job
description: Launch and inspect long builds, watchers, or development servers in persistent tmux panes with automatic Pi completion follow-ups, disk logs and real exit codes. Use when a command needs background execution or reconnection, not for short commands or subagent orchestration.
---

# Long-running commands

Use ordinary Bash for short work. Requires interactive Pi inside tmux, Bash, jq
and flock. This is a command runner, not a fallback for failed subagents.

## Launch

Resolve `launch.sh` relative to this skill directory. Pass the actual working
directory, not an assumed Git root, one Bash command string, and a short task
description:

```sh
bash /path/to/tmux-job/launch.sh /absolute/project 'npm run build' run_npm_build
```

Always provide a meaningful description, such as `run_npm_install` or
`test_auth_flow`. Use 1-48 letters, digits, underscores, or hyphens, starting with
a letter or digit. Do not include secrets. The pane title is `job:<description>`.
Internal job directories and pane IDs identify jobs, so duplicate descriptions
are safe. Older two-argument calls remain valid as `job:command`.

The first job opens to the right of Pi, using 40% of Pi's pane width. Further
jobs stack below it in the same column, with heights rebalanced evenly and
keyboard focus unchanged. Finished panes remain until explicitly removed and
still count toward the column. Existing jobs in other windows are not moved.
Pane titles appear only in windows containing Pi job panes, including finished
panes and separate job windows. Closing the last job pane hides the titles,
even if manual splits remain. The launcher and `~/.tmux.conf` load the same
`pane-titles.tmux` rule; Pi reloads do not reset it.

Starting a column requires at least 40 columns and four content rows in Pi's pane
after reserving a row for titles.
If the window is zoomed, there is too little space, another job would leave
fewer than four rows per pane, or a manually changed column cannot be safely
rebalanced, launch in a separate `job:<description>` window instead. Shared window names
and rename settings are left alone; fallback window names are protected from renaming.

Launch through Pi's Bash tool: its `PI_SESSION_ID` ties the job to this conversation.
The `tmux-jobs` extension shows pending jobs in the footer and automatically delivers
completion plus a bounded log tail, triggering a follow-up turn when Pi is idle.
Do other work or return control; do not poll or use `bg_wait` for these jobs.
On completion, continue the original task without requiring another user prompt.

The returned directory is the job ID. Immediately report it, the cwd, and how
to inspect the pane. Save it in the handoff before moving on. Each invocation
starts a NEW job: after a timeout/lost reply, inspect existing jobs before retrying.
Records live under `${XDG_STATE_HOME:-$HOME/.local/state}/pi/jobs/job.*`.

Commands run in foreground inside their pane, using Bash with `pipefail` and
the tmux environment (plus the launcher's PATH). Put required environment
assignments in the command; do not use `&`, `nohup`, or daemon mode inside it.

## Inspect / reconnect

```sh
job='/returned/job/directory'
socket=$(jq -r .socket "$job/job.json")
pane=$(jq -r .pane "$job/job.json")
tmux -S "$socket" display-message -p -t "$pane" \
  'job=#{@pi_job} dead=#{pane_dead} exit=#{pane_dead_status} signal=#{pane_dead_signal}'
tail -c 16384 "$job/output.log"
```

Read `command.sh`, `job.json`, and `exit` with the read tool as needed.
A valid integer `exit` file is the command's result: zero succeeded, nonzero
failed. No exit file with a live owned pane means pending/running, not success.
A missing/dead pane without that file means incomplete/unknown; report any native
exit/signal evidence separately. Silence is not progress or completion.
For servers/watchers, check readiness separately (for example, a health endpoint).

Select the window and pane only after checking ownership; pane IDs can be
reused after a server restart:

```sh
test "$(tmux -S "$socket" show-option -pqv -t "$pane" @pi_job)" = "$job" &&
  tmux -S "$socket" select-window -t "$pane" \; select-pane -t "$pane"
```

Outside tmux, first attach with
`tmux -S "$socket" attach-session -t "$(jq -r .session "$job/job.json")"`.

## Interrupt / cleanup

For an explicitly requested stop, recheck ownership and send Ctrl-C:

```sh
test "$(tmux -S "$socket" show-option -pqv -t "$pane" @pi_job)" = "$job" &&
  tmux -S "$socket" send-keys -t "$pane" C-c
```

This requests interruption; verify exit before claiming it stopped. If it stays
alive, report that rather than escalating silently. For an approved forced stop
or removal of a finished pane, use the same ownership check with `kill-pane`.
Never kill the user's session/server. Keep logs until explicit cleanup; remove
only the selected job directory after the process is confirmed stopped.

Jobs survive Pi `/reload` and exit, not tmux-server loss or reboot. Closing a
shared window kills Pi and every job pane in it. On reload or resuming the
owning conversation, the extension recovers undelivered results;
new/forked conversations do not adopt another session's jobs. Delivered messages
in session history prevent repeated notifications. Use one live Pi per session.
Never replay saved commands automatically. Shell-only launches without
`PI_SESSION_ID` remain manually inspected; headless Pi is not kept alive.
Logs are raw terminal output and grow until cleaned up; use bounded reads.
