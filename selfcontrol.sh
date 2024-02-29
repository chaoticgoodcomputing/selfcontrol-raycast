#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SelfControl for...
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💀
# @raycast.argument1 { "type": "text", "placeholder": "minutes" }
# @raycast.packageName CGC Developer Utils

# Documentation:
# @raycast.description Runs SelfControl for a given amount of minutes
# @raycast.author Spencer Elkington
# @raycast.authorURL https://chaoticgood.computer

# Check if the timer argument is provided
set -e
if [ $# -eq 0 ]; then
  echo "Please provide a timer value."
  exit 1
fi

# Check if the timer argument is a number
if ! [[ $1 =~ ^[0-9]+$ ]]; then
  echo "Please provide a valid timer value."
  exit 1
fi

# check if the timer argument is less that 60
if [ $1 -ge 61 ]; then
  echo "Please provide a timer value less than 60 minutes."
  exit 1
fi

# Read the timer argument
SELF_CONTROL_CLI=~/Applications/SelfControl.app/Contents/MacOS/selfcontrol-cli
timer=$1

# Add the timer variable to the current datetime as an ISO8601 value
timer_datetime=$(date -u -v+${timer}M +"%Y-%m-%dT%H:%M:%SZ")

# check if `selfcontrol-cli isrunning` contains "YES"
if [[ $($SELF_CONTROL_CLI is-running 2>&1) == *"YES"* ]]; then
  echo "SelfControl is already running."
  exit 1
fi

echo $timer_datetime

$SELF_CONTROL_CLI start --blocklist ~/.blocklist.selfcontrol --enddate $timer_datetime