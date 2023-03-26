#!/bin/bash

toggle() {
    STATUS="$(bluetoothctl show | grep Powered | awk '{print $2}')"
    if [ $STATUS == "yes" ]; then
        bluetoothctl power off
        notify-send -a "Bluetooth" --icon=bluetooth-offline --urgency=normal "Bluetooth" "Bluetooth has been turned off."
    else
        bluetoothctl power on
        notify-send -a "Bluetooth" --icon=volume-level-high --urgency=normal "Bluetooth" "Bluetooth has been turned on."
    fi
}

if [[ $1 == "--toggle" ]]; then
        toggle
fi
