#!/usr/bin/env bash
get_tmux_option() {
  # This helper function will get the value of the tmux variable
  # or set it to a given value if it is not set
  local option=$1
  local default_value="$2"
  local option_value
  option_value=$(tmux show-options -gqv "$option")
  if [ "$option_value" != "" ]; then
    echo "$option_value"
    return
  fi
  echo "$default_value"
}

# Catppuccin Macchiato colors
thm_bg="default" # Transparent background
thm_fg="#cad3f5"
thm_blue="#8aadf4"
thm_mauve="#c6a0f6"
thm_red="#ed8796"
thm_green="#a6da95"
thm_yellow="#eed49f"
thm_surface_2="#5b6078"

# Most of the variables are prefixed with `@minimal-tmux-` so that tmux has a unique namespace
#
# The variables are:
# - @minimal-tmux-bg: background color of the status line
# - @minimal-tmux-fg: foreground color of the status line
# - @minimal-tmux-status: position of the status line (top or bottom)
# - @minimal-tmux-justify: justification of the status line (left, centre or right)
# - @minimal-tmux-indicator: whether to show the indicator of the prefix
# - @minimal-tmux-indicator-str: string of the indicator
# - @minimal-tmux-right: whether to show the right side of the status line
# - @minimal-tmux-left: whether to show the left side of the status line
# - @minimal-tmux-status-right: content of the right side of the status line
# - @minimal-tmux-status-left: content of the left side of the status line
# - @minimal-tmux-status-right-extra: extra content of the right side of the status line
# - @minimal-tmux-status-left-extra: extra content of the left side of the status line
# - @minimal-tmux-window-status-format: format of the window status
# - @minimal-tmux-expanded-icon: icon for expanded windows
# - @minimal-tmux-show-expanded-icon-for-all-tabs: whether to show the expanded icon for all tabs
# - @minimal-tmux-use-arrow: whether to use arrows in the status line
# - @minimal-tmux-right-arrow: right arrow symbol
# - @minimal-tmux-left-arrow: right left symbol
default_color="#[bg=default,fg=${thm_fg},bold]"

# variables
bg=$(get_tmux_option "@minimal-tmux-bg" "$thm_blue")
fg=$(get_tmux_option "@minimal-tmux-fg" "#24273a") # Using dark color for text on blue background
use_arrow=$(get_tmux_option "@minimal-tmux-use-arrow" true)
larrow="$("$use_arrow" && get_tmux_option "@minimal-tmux-left-arrow" "")"
rarrow="$("$use_arrow" && get_tmux_option "@minimal-tmux-right-arrow" "")"
status=$(get_tmux_option "@minimal-tmux-status" "bottom")
justify=$(get_tmux_option "@minimal-tmux-justify" "left") # Changed to left justification
indicator_state=$(get_tmux_option "@minimal-tmux-indicator" true)
indicator_str=$(get_tmux_option "@minimal-tmux-indicator-str" " tmux ")
indicator=$("$indicator_state" && echo " $indicator_str ")
right_state=$(get_tmux_option "@minimal-tmux-right" true)
left_state=$(get_tmux_option "@minimal-tmux-left" true)
status_right=$("$right_state" && get_tmux_option "@minimal-tmux-status-right" "#[fg=${thm_blue}]#S")
status_left=$("$left_state" && get_tmux_option "@minimal-tmux-status-left" "${default_color}#{?client_prefix,,${indicator}}#[bg=${bg},fg=${fg},bold]#{?client_prefix,${indicator},}${default_color}")
status_right_extra="$status_right$(get_tmux_option "@minimal-tmux-status-right-extra" "")"
status_left_extra="$status_left$(get_tmux_option "@minimal-tmux-status-left-extra" "")"
window_status_format=$(get_tmux_option "@minimal-tmux-window-status-format" ' #I:#W ')
expanded_icon=$(get_tmux_option "@minimal-tmux-expanded-icon" '󰊓 ')
show_expanded_icon_for_all_tabs=$(get_tmux_option "@minimal-tmux-show-expanded-icon-for-all-tabs" false)

# Setting the options in tmux
tmux set-option -g status-position "$status"
tmux set-option -g status-style bg=default,fg=$thm_fg # Transparent background
tmux set-option -g status-justify "left" # Ensure windows are left-justified

# Window styles
tmux set-option -g window-status-format "#[fg=$thm_surface_2]$window_status_format"
"$show_expanded_icon_for_all_tabs" && tmux set-option -g window-status-format "#[fg=$thm_surface_2]${window_status_format}#{?window_zoomed_flag,${expanded_icon},}"

# Active window
tmux set-option -g window-status-current-format "#[fg=${bg}]$larrow#[bg=${bg},fg=${fg}]${window_status_format}#{?window_zoomed_flag,${expanded_icon},}#[fg=${bg},bg=default]$rarrow"

# Set other tmux styling
tmux set-option -g pane-border-style fg=$thm_surface_2
tmux set-option -g pane-active-border-style fg=$thm_blue
tmux set-option -g message-style bg=$thm_mauve,fg="#24273a"
tmux set-option -g message-command-style bg=$thm_mauve,fg="#24273a"
tmux set-option -g mode-style bg=$thm_mauve,fg="#24273a"
