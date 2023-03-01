#### COLOUR
tm_icon=" λ "

tm_bg="#dce0e8"
tm_fg="#4c4f69"

# separators
tm_separator_left_bold="◀"
tm_separator_left_thin="❮"
tm_separator_right_bold=">"
tm_separator_right_thin=">"

set -g status on

set-option -g status-left-length 150
set -g status-right-length 150
set -g status-interval 2

set-option -g status-position bottom
set -g status-justify left

# default statusbar colors
set status-bg $tm_bg

setw -g window-status-current-style bg=$tm_bg,fg=$tm_fg,dim
setw -g window-status-style bg=$tm_bg,fg=$tm_fg,default

# default window title colors
setw -g window-status-style bg=$tm_bg,fg=$tm_fg,none
set -g window-status-format "| #I #W"

# active window title colors
setw -g window-status-current-style bg=$tm_bg,fg=$tm_fg,dim
setw -g window-status-current-format "| #[bold]#I #W"

# pane border
set -g pane-border-style bg=$tm_bg,fg=$tm_fg
set -g pane-active-border-style bg=$tm_bg,fg=$tm_fg

# message text
set -g message-style bg=$tm_bg,fg=$tm_fg,bold

# pane number display
set-option -g display-panes-active-colour $tm_fg
set-option -g display-panes-colour $tm_fg

# clock
set-window-option -g clock-mode-colour $tm_fg

tm_tunes="#(~/dotfiles/applescripts/itunes-current-track-tmux.sh)"

tm_date="#[fg=$tm_fg] %R %d %b"
tm_session_name="#[fg=$tm_fg,bold]$tm_icon[#S]"

set -g status-left $tm_session_name' '
set -g status-right $tm_tunes' '$tm_date
