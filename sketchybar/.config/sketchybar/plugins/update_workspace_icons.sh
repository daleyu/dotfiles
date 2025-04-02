#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"

# Function to update space icons based on applications in each workspace
update_space_icons() {
    local sid=$1
    # Get list of applications in the workspace
    local apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    
    # Make sure the space is being drawn
    sketchybar --set space.$sid drawing=on
    
    # Create the icon strip based on running applications
    if [ -n "${apps}" ]; then
        icon_strip=" "
        while read -r app; do
            # Use your existing icon mapping function
            icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
        done <<<"${apps}"
    else
        icon_strip=""
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
    # Update the previously focused workspace (if available)
    if [ -n "$AEROSPACE_PREV_WORKSPACE" ]; then
        update_space_icons "$AEROSPACE_PREV_WORKSPACE"
    fi
    
    # Update the currently focused workspace
    update_space_icons "$AEROSPACE_FOCUSED_WORKSPACE"
else
    # Update all workspaces to ensure clean state
    for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
        for sid in $(aerospace list-workspaces --monitor "$monitor"); do
            update_space_icons "$sid"
        done
    done
fi
