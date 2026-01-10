#!/bin/sh

# Check for required dependencies
if ! command -v setxkbmap >/dev/null 2>&1; then
    echo "Error: setxkbmap is not installed. Install with: sudo apt install x11-xkb-utils" >&2
    exit 1
fi

if ! command -v xcape >/dev/null 2>&1; then
    echo "Error: xcape is not installed. Install with: sudo apt install xcape" >&2
    exit 1
fi

setxkbmap -option ctrl:nocaps
xcape -e "Control_L=Escape"
