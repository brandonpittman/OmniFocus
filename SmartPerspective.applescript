# Big thanks to [ediventurin](https://twitter.com/ediventurin) for additions to SmartPerspective!

on run
	open_perspective()
end run

on open_perspective()
	tell application "OmniFocus"
		tell default document
			
			# Inbox
			if (count (every inbox task)) > 0 then
				my conditions("Inbox")
				return
			end if
			
			# Routines
			set nRoutines to count (every available task of every flattened context where name of containing project's folder = "Routines")
			if nRoutines > 0 then
				my conditions("Routines")
				return
			end if
			
			# Flagged
			set nFlagged to count (every available task of every flattened context whose flagged is true)
			if (nFlagged) > 0 then
				my conditions("Flagged")
				return
			end if
			
			# Available
			set nTotalAvailable to count (every available task of every flattened context)
			if (nTotalAvailable) > 0 then
				my conditions("Available")
				return
			end if
			
			# Forecast
			my conditions("Forecast")
			
		end tell
	end tell
end open_perspective

# Perspectives
on conditions(perName)
	tell application "OmniFocus"
		tell default document
			if visible of front document window is true then
				set perspective name of document window 1 to perName
			else
				make new document window with properties {perspective name:perName} at end of document windows
				activate
			end if
		end tell
	end tell
end conditions

# For debugging
# Usage: my notify("Label", variable)
on notify(theTitle, theDescription)
	display notification theDescription with title theTitle
end notify
