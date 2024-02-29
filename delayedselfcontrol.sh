#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SelfControl in...
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💀
# @raycast.argument1 { "type": "text", "placeholder": "delay" }
# @raycast.argument2 { "type": "text", "placeholder": "duration" }
# @raycast.packageName CGC Developer Utils

# Documentation:
# @raycast.description Schedules SelfControl to start after a delay
# @raycast.author Spencer Elkington
# @raycast.authorURL https://chaoticgood.computer

set -e

# Verify both arguments exist and are numbers less than 60
if [ $# -ne 2 ]; then
  echo "Please provide a delay and duration."
  exit 1
fi

if ! [[ $1 =~ ^[0-9]+$ ]] || ! [[ $2 =~ ^[0-9]+$ ]]; then
  echo "Please provide a valid delay and duration."
  exit 1
fi

if [ $1 -ge 61 ] || [ $2 -ge 61 ]; then
  echo "Please provide a delay and duration less than 60 minutes."
  exit 1
fi

# Set pluralization for the duration
if [ $1 -eq 1 ]; then
  duration="1 minute"
else
  duration="$1 minutes"
fi

SCRIPT_PWD=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
SECONDS=$(( $1 * 60 ))

# (sleep $SECONDS && ${SCRIPT_PWD}/selfcontrol.sh ${2}) &
echo "Scheduling SelfControl to start at $(date -v+${1}M +"%H:%M:%S") for $2 minutes."
sleep $SECONDS
echo "SelfControl session starting in 30 seconds!"
sleep 30
${SCRIPT_PWD}/selfcontrol.sh ${2}