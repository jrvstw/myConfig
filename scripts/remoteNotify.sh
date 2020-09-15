#!/bin/bash

get="getMy"
serverName=$(${get} serverName)

telegram-cli -D -W server.pub -e "msg ${serverName} $*"

