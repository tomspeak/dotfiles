# Retained job panes still count; ordinary manual splits do not.
# Expand the event window first, then its panes. -q tolerates a removed window.
set-hook -gw window-layout-changed[50] 'run-shell -C "set-option -wq -t #{hook_window} -F pane-border-status \"##{?##{P:##{@pi_job}},top,off}\""'
set-hook -g window-linked[50] 'run-shell -C "set-option -wq -t #{hook_window} -F pane-border-status \"##{?##{P:##{@pi_job}},top,off}\""'
