on run
	open_perspective()
end run

on open_perspective()
	tell application "OmniFocus"
		tell default document
			
			(*
			set incomplete to inbox tasks where completed is false
			if (count incomplete) > 0 then --this is for your Inbox
				my conditions("Inbox")
				return
			end if
*)
			
			set weekly to number of available tasks of flattened project "weekly"
			set daily to number of available tasks of flattened project "daily"
			
			if weekly + daily > 0 then --this could be titled "Routine" possibly
				my conditions("Routine")
				return
			end if
			if (count (every available task of every flattened context whose flagged is true)) > 0 then
				my conditions("Flagged")
				return
			end if
			if (count (every available task of every flattened context)) > 0 then
				my conditions("Next Actions")
				return
			end if
			if (count (every inbox task)) > 0 then
				my conditions("Inbox")
				return
			end if
			my conditions("Forecast")
		end tell
	end tell
end open_perspective

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
