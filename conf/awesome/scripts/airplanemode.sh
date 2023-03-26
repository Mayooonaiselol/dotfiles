#!/usr/bin/bash
STATUS="$(rfkill list | sed -n 2p | awk '{print $3}')"

toggle() {
    if [[ $STATUS == "no" ]]; then
        getroot 'pkexec rfkill block all'
        notify-send --urgency=normal "Airplane Mode" "Airplane mode has been turned on!"
    else
        getroot 'pkexec rfkill unblock all'
        notify-send --urgency=normal "Airplane Mode" "Airplane mode has been turned off!"
    fi
}

if [[ $1 == "--toggle" ]]; then
    toggle
fi
