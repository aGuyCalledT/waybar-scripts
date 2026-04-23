#!/bin/bash

devices=$(kdeconnect-cli -a --name-only)

if [ -z "$devices" ]; then
    echo '{"text": "󰥍", "tooltip": "not connected", "class": "disconnected"}'
else
    echo "{\"text\": \"$devices 󰄜\", \"tooltip\": \"connected: $devices\", \"class\": \"connected\"}"
fi
