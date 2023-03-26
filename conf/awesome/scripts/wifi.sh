#!/usr/bin/env bash
STATUS=$(nmcli radio wifi)

toggle() {
    if [[ $STATUS == "enabled" ]]; then
        nmcli radio wifi off
        notify-send -a "wifi"  --urgency=normal "Wi-Fi" "Wi-Fi has been turned off!"
    else
        nmcli radio wifi on
        notify-send -a "wifi"  --urgency=normal "Wi-Fi" "Wi-Fi has been turned on, you are back online!"
    fi
}

if [[ $1 == "--toggle" ]]; then
    toggle
fi
