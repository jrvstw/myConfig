#!/bin/bash

xmodmapDir=$(readlink -f $(dirname $0)/../drivers/xmodmap)

while [ -n "$1" ]; do
    if [ "$1" == "myLayout" ]; then
        xmodmap ${xmodmapDir}/my-keyboard-layout
    elif [ "$1" == "esc" ]; then
        xmodmap ${xmodmapDir}/swap_esc_capslock
    elif [ "$1" == "lCtrl" ]; then
        xmodmap ${xmodmapDir}/swap_lCtrl_lAlt
    elif [ "$1" == "rCtrl" ]; then
        xmodmap ${xmodmapDir}/swap_rCtrl_rAlt
    elif [ "$1" == "tester" ]; then
        test -f ${xmodmapDir}/swap_rCtrl_rAlt && echo true || echo false
    elif [ "$1" == "default" ]; then
        setxkbmap
    else
        echo "$1: command not found."
    fi
    shift
done

