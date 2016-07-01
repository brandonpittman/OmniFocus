---
:title: 'Colonize: AppleScript to Wrangle Prefixed Tasks in OmniFocus'
:tags: omnifocus, applescript
:date: 2016-06-30
---
I just whipped up a neat little script that uses the latest version of my OmniFocus Library. It's called [Colonize](https://github.com/brandonpittman/OmniFocus). You can use it to select some tasks in OmniFocus, and then if you run `Colonize.scpt`, it'll switch the first word of the task name into a prefix or into a bare word if the first word is already a prefix. This makes handling tasks like `Review daily logs` and `Review: daily logs` easy.

Here's the code:

```applescript
use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
use O : script "omnifocus"
use OmniFocus : application "OmniFocus"

on run
	tell O to toggleColon(selectedItems())
end run

on handle_string(argv)
	if argv is "set" then
		O's setColon(selectedItems() of O)
	else if argv is "clear" then
		O's clearColon(selectedItems() of O)
	end if
end handle_string
```

You will, of course, need my library installed first. This script is set up to work with LaunchBar already. If you pass "set" or "clear" to the script (or on the command line), instead of toggling, it'll blank set or clear colons.
