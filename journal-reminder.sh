#!/bin/bash

VAULT_NAME="Vault"
ICON="obsidian"
REMIND_DELAY="1h"
STATE_FILE="$HOME/.cache/journal_last_run"
TARGET_HOUR=18

send_sway_notification() {
    ACTION=$(notify-send "daily journal" "would you like to do your daily journal entry now?" \
        --icon="$ICON" \
        --wait \
        --action="yes=yes" \
        --action="remind=later" \
        --action="no=no")

    case "$ACTION" in
    "yes")
        xdg-open "obsidian://advanced-uri?vault=$VAULT_NAME&daily=true"
        date +%Y-%m-%d >"$STATE_FILE"
        ;;
    "remind")
        sleep "$REMIND_DELAY"
        send_sway_notification
        ;;
    "no")
        date +%Y-%m-%d >"$STATE_FILE"
        ;;
    esac
}

if [[ "$1" == "test" ]]; then
    send_sway_notification
    exit 0
fi

# MAIN LOOP
while true; do
    CURRENT_HOUR=$(date +%H)
    LAST_RUN=$(cat "$STATE_FILE" 2>/dev/null)
    TODAY=$(date +%Y-%m-%d)

    if [ "$CURRENT_HOUR" -ge "$TARGET_HOUR" ] && [ "$LAST_RUN" != "$TODAY" ]; then
        send_sway_notification
    fi

    sleep 600
done
