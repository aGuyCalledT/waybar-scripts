#!/bin/bash
echo "auto-connect to bluetooth device..."

LAST_DEVICE=$(bluetoothctl devices | head -n 1 | cut -d ' ' -f 2)

if [ -z "$LAST_DEVICE" ]; then
    echo "no saved bluetooth device found."
    exit 1
fi

DEVICE_NAME=$(bluetoothctl devices | head -n 1 | cut -d ' ' -f 3-)

echo "trying to connect to '$DEVICE_NAME' ($LAST_DEVICE)..."

bluetoothctl connect "$LAST_DEVICE"
