#!/bin/zsh

if [[ $# -eq 0 ]]; then
    open -a "OmniFocus"
    return 0
else
  osascript <<TASK
    tell application "OmniFocus"
      parse tasks into default document with transport text "$@"
    end tell
    return "Your task was successfully added to OmniFocus."
TASK
fi
