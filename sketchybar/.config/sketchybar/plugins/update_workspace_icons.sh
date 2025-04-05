#!/bin/bash
CONFIG_DIR="$HOME/.config/sketchybar"

# Function to update space icons based on applications in each workspace
update_space_icons() {
    local sid=$1
    
    # Get list of applications in the workspace with improved parsing
    # This uses aerospace's list-windows command with a specific workspace filter
    local app_list=$(aerospace list-windows --workspace "$sid" | grep -v "^No windows" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    
    # Make sure the space is being drawn
    sketchybar --set space.$sid drawing=on
    
    # Create the icon strip based on running applications
    if [ -n "$app_list" ]; then
        icon_strip=""
        while IFS= read -r app; do
            if [ -n "$app" ]; then
                # Use your existing icon mapping function
                app_icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
                [ -n "$app_icon" ] && icon_strip+=" $app_icon"
            fi
        done <<< "$app_list"
    else
        icon_strip=" —"  # Empty workspace indicator
    fi
    
    # Update the space label with application icons
    sketchybar --set space.$sid label="$icon_strip"
    
    # Update highlighting for current workspace
    if [ "$sid" -eq "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
        sketchybar --set space.$sid icon.highlight=true label.highlight=true background.border_color=0xff9ece6a
    else
        sketchybar --set space.$sid icon.highlight=false label.highlight=false background.border_color=0xff414868
    fi
}

# If we have a specific focused workspace from the trigger, use it
if [ -n "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
    # We should update all workspaces to ensure proper icon distribution
    for sid in {1..8}; do
        update_space_icons "$sid"
    done
else
    # Update all workspaces on script startup
    for sid in {1..8}; do
        update_space_icons "$sid"
    done
fi
