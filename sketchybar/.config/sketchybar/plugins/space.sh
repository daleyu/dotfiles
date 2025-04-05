#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

for i in "${!space_icons[@]}"
do
  sid=$(($i+1))
  sketchybar --add space space.$sid left                                 \
             --set space.$sid associated_space=$sid                      \
                              icon=$sid                                  \
                              icon.padding_left=8                        \
                              icon.padding_right=4                       \
                              background.padding_left=4                  \
                              background.padding_right=4                 \
                              background.color=0x44ffffff                \
                              background.corner_radius=5                 \
                              background.height=22                       \
                              background.drawing=off                     \
                              label.drawing=on                           \
                              click_script="aerospace workspace $sid"
done
