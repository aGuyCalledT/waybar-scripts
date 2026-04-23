#!/bin/bash

IGNORE_LIST=(
    "alsa_output.pci-0000_2d_00.1.hdmi-stereo"
    "alsa_output.platform-snd_aloop.0.analog-stereo"
    "alsa_output.pci-0000_2f_00.4.iec958-stereo"
    "alsa_output.usb-Blue_Microphones_Yeti_Stereo_Microphone-00.analog-stereo"
)

CURRENT_SINK=$(pactl get-default-sink)
SINKS=$(pactl list short sinks | awk '{print $2}')

VALID_SINKS=()
for SINK in $SINKS; do
    IGNORE=false
    for SKIP in "${IGNORE_LIST[@]}"; do
        [[ "$SINK" == "$SKIP" ]] && IGNORE=true && break
    done
    [[ "$IGNORE" == false ]] && VALID_SINKS+=("$SINK")
done

NEXT_SINK=""
for i in "${!VALID_SINKS[@]}"; do
    if [[ "${VALID_SINKS[$i]}" == "$CURRENT_SINK" ]]; then
        NEXT_INDEX=$(((i + 1) % ${#VALID_SINKS[@]}))
        NEXT_SINK="${VALID_SINKS[$NEXT_INDEX]}"
        break
    fi
done

[[ -z "$NEXT_SINK" ]] && NEXT_SINK="${VALID_SINKS[0]}"

pactl set-default-sink "$NEXT_SINK"
pactl list sink-inputs short | awk '{print $1}' | while read -r STREAM; do
    pactl move-sink-input "$STREAM" "$NEXT_SINK"
done

SINK_PROPS=$(pactl list sinks | grep -A 50 "Name: $NEXT_SINK")
FRIENDLY_NAME=$(echo "$SINK_PROPS" | grep "Description:" | cut -d: -f2- | xargs)

ICON="audio-speakers"
if [[ "$SINK_PROPS" == *"bluetooth"* ]]; then
    ICON="bluetooth"
elif [[ "$SINK_PROPS" == *"headset"* ]] || [[ "$SINK_PROPS" == *"headphone"* ]]; then
    ICON="audio-headphones"
fi

notify-send "Audio Output" "Active: $FRIENDLY_NAME" -i "$ICON"
