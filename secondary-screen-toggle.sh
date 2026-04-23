#!/bin/bash

MONITOR="DP-2"
SETTINGS="2560x1440@170.0,0x0,1.0"

IF_ACTIVE=$(hyprctl monitors | grep "$MONITOR")

if [ -n "$IF_ACTIVE" ]; then
    hyprctl keyword monitor "$MONITOR, disable"
    notify-send -i "preferences-desktop-display" "Monitor Toggle" "Monitor ($MONITOR) turned off"
else
    hyprctl keyword monitor "$MONITOR, $SETTINGS"
    notify-send -i "preferences-desktop-display" "Monitor Toggle" "Monitor ($MONITOR) turned on"
fi
