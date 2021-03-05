#!/bin/bash

get="getMy"

if [[ "$@" == "lab" ]]; then
    ssh $(${get} lab401User)@$(${get} lab401Address)

elif [[ "$@" == "home" ]]; then
    user=$(${get} serverUser)
    addr=$(${get} serverAddress)
    port=$(${get} serverSSHPort)
    ssh ${user}@${addr} -p${port}

else
    echo 'connect.sh: missing operand'
    exit 1

fi

