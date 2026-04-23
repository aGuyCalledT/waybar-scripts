#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

mem_used=$(free -g | awk '/Mem:/ {print $3}')
mem_total=$(free -g | awk '/Mem:/ {print $2}')

temp=$(sensors | grep -E 'Tctl|Package id 0|Core 0' | head -n 1 | awk '{print $2}' | sed 's/+//;s/°C//')

disk_usage=$(df -h / | awk 'NR==2 {print $5}')

tooltip="󰍛 CPU: ${cpu_usage}%\n"
tooltip+="󰾆 RAM: ${mem_used}GB / ${mem_total}GB\n"
tooltip+="󰈸 Temp: ${temp}°C\n"
tooltip+="󰋊 Disk: ${disk_usage}"

echo "{\"text\": \"󰣇\", \"tooltip\": \"$tooltip\"}"
