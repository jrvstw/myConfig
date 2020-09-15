#!/bin/bash
if [ -n "$1" ]; then
    cd $1 || exit
fi
ip a | grep "inet "
python3 -m http.server

