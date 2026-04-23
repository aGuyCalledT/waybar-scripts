# waybar-scripts
this collection contains bash scripts for automation and waybar integration on a hyperland linux system

### auto-bluetooth.sh
connects to the most recently paired bluetooth device automatically.
### journal-reminder.sh
triggers a desktop notification at 18:00 to prompt for an obsidian daily journal entry.
### kde-indicator.sh
to show the connection status of kde connect.
### layout-toggle.sh
toggles between keyboard layouts.
### overview.sh
gathers system metrics including cpu usage, ram, temperature, and disk space for waybar tooltips.
### secondary-screen-toggle.sh
enables or disables a specific secondary monitor.
### sound-toggle.sh
cycles through valid audio output sinks.
### vpn-network.sh
manages a custom systemd service for protonvpn.

## requirements
* hyprland
* waybar
* openvpn
* jq
* pactl
* libnotify

## installation
make the scripts executable:
```bash
chmod +x *.sh
