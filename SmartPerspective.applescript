on run
	open_perspective()
end run

on open_perspective()
	tell application "OmniFocus"
		tell default document
			
			-- Inbox
			if (count (every inbox task)) > 0 then
				my conditions("Inbox")
				return
			end if
			
			-- Routines
			set nRoutines to count (every available task of every flattened context where name of containing project's folder = "Routines")
			if nRoutines > 0 then
				my conditions("Routines")
				return
			end if
			
			-- Due > Forecast
			set currDate to (current date) - (time of (current date)) + (24 * hours - 1)
			set nDue to count (every available task of every flattened context whose due date is not greater than currDate)
			if (nDue) > 0 then
				my conditions("Forecast")
				return
			end if
			
			-- Flagged
			set nFlagged to count (every available task of every flattened context whose flagged is true)
			if (nFlagged) > 0 then
				my conditions("Flagged")
				return
			end if
			
			-- Available > Today (except folder "Next time (in)…", used for location-based contexts)
			set nTotalAvailable to count (every available task of every flattened context)
			set nErrandsInFolder to count (every available task of every flattened context where name of containing project's folder = "Next time (in)...")
			if (nTotalAvailable - nErrandsInFolder) > 0 then
				my conditions("Today")
				return
			end if
			
			-- Someday/Maybe tasks
			my conditions("Someday")
			
		end tell
	end tell
end open_perspective

-- Perspectives
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

-- For debugging | Usage: my notify("Label", variable)
on notify(theTitle, theDescription)
	display notification theDescription with title theTitle
end notify
