#!/bin/bash

sounds="$HOME/.config/hypr/scripts/Sounds.sh"

hyprctl switchxkblayout current next

sleep 0.1

LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | head -n 1)

case "$LAYOUT" in
*"German"*)
    FLAG="🇩🇪"
    ;;
*"English"*)
    FLAG="🇺🇸"
    ;;
*)
    FLAG="🇨🇳"
    ;;
esac

notify-send -e -u low -i input-keyboard "keyboard layout" "$FLAG $LAYOUT"

if [ -f "$sounds" ]; then
    bash "$sounds" --bell
fi
