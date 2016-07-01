I wrote another cool little tool using my AppleScript library. It's called [Considered](https://github.com/brandonpittman/OmniFocus). It also handles things having to do with colons and prefixes, but specifically the **Consider:** prefix. If you're unfamiliar with considered tasks, read all about them [here](http://www.usingomnifocus.com/2014/01/the-considered-task/). Instead of trying to set task names to something like "Consider reviewing" with the **ing**, I opted for Kourosh Dini's prefix-style considered tasks where you just add **Consider:** as a prefix. It's simpler and easier to script. Here's the code (using my OmniFocus library, of course.)

```applescript
use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
use O : script "omnifocus"
use OmniFocus : application "OmniFocus"

on run
	tell O to toggleConsider(selectedItems())
end run

on handle_string(argv)
	if argv is "set" then
		tell O to setConsider(selectedItems())
	else if argv is "clear" then
		tell O to clearConsider(selectedItems())
	end if
end handle_string
```

It's a pretty nifty script that will toggle consider prefixes on and off. It's set up to accept an argument with LaunchBar (either "set" or "clear") to flip the considered switch one way or the other no matter what the current state.
