#!/bin/bash

# This script is named just OmniFocus because I use "of" as a Fish shell function.
# The Bash version is faster when run from Vim, so I use this as well.

if [[ $# -eq 0 ]]; then
  open -a OmniFocus
else
  osascript -e "tell application \"OmniFocus\" to parse tasks into default document with transport text \"$@\"" > /dev/null
fi
