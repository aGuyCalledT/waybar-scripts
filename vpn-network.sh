#!/bin/bash

if [ "$1" == "toggle" ]; then
    if systemctl is-active --quiet protonvpn.service; then
        sudo systemctl stop protonvpn.service
        notify-send -e -u low -t 2000 -i "dialog-warning" "ProtonVPN" "Status: disconnected\n"
        $HOME/.config/hypr/scripts/Sounds.sh --removed
    else
        sudo systemctl start protonvpn.service
        notify-send -e -u low -t 2000 -i "protonvpn-logo" "ProtonVPN" "Status: connected\n"
        $HOME/.config/hypr/scripts/Sounds.sh --added
    fi
    exit
fi

VPN_ACTIVE=false
if systemctl is-active --quiet protonvpn.service; then
    VPN_ACTIVE=true
fi

WIFI_INFO=$(nmcli -t -f IN-USE,SSID,SIGNAL dev wifi list 2>/dev/null | grep "^\*")

if [ -z "$WIFI_INFO" ]; then
    if nmcli -t -f TYPE,STATE dev | grep -q "ethernet:connected"; then
        echo '{"text": "wired 󰌘", "tooltip": "ethernet connected", "class": "ethernet"}'
    else
        echo '{"text": "disconnected 󰤮", "tooltip": "no connection", "class": "disconnected"}'
    fi
    exit
fi

SSID=$(echo "$WIFI_INFO" | cut -d':' -f2)
SIGNAL=$(echo "$WIFI_INFO" | cut -d':' -f3)

IDX=$((($SIGNAL + 10) / 20))
if [ $IDX -gt 4 ]; then IDX=4; fi

if [ "$VPN_ACTIVE" = true ]; then
    ICONS=("󰤬" "󰤡" "󰤤" "󰤧" "󰤪")
    CLASS="vpn-on"
    TOOLTIP="󰖂  connected"
else
    ICONS=("󰤫" "󰤠" "󰤣" "󰤦" "󰤩")
    CLASS="vpn-off"
    TOOLTIP="󰖂  disconnected"
fi

ICON=${ICONS[$IDX]}

echo "{\"text\": \"$SSID $ICON\", \"tooltip\": \"$TOOLTIP | Signal: $SIGNAL%\", \"class\": \"$CLASS\"}"
