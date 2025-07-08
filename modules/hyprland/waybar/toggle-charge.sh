#!/usr/bin/env bash

FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

if [ ! -f "$FILE" ]; then
  notify-send "Battery Toggle" "Conservation mode not available."
  exit 1
fi

MODE=$(cat "$FILE")
notify-send "Battery Toggle" "Current mode: $MODE"
if [ "$MODE" = "1" ]; then
  sudo sh -c "echo 0 > '$FILE'" && notify-send "Battery Mode" "Charging to 100%" || notify-send "Battery Mode" "Failed to switch to 100%"
else
  sudo sh -c "echo 1 > '$FILE'" && notify-send "Battery Mode" "Charging limited to 60%" || notify-send "Battery Mode" "Failed to switch to conservation mode"
fi
