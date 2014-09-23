# This version of SmartPerspective includes support for Location Helper. It's free in the App Store.
#
# http://www.mousedown.net/mouseware/LocationHelper.html
# https://itunes.apple.com/us/app/location-helper-for-applescript/id488536386?mt=12

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
			
			# set myWork to the coordinates of the location you want to check on
			set myWork to {XX.XXXXXXX, XX.XXXXXXXX}
			
			# This is wrapped in a try block in case you don't have Location Helper installed.
			try
				tell application "Location Helper"
					set distanceFromWork to get distance from coordinates myWork
				end tell
				
				# 2000 == 2km
				# Set this is whatever you like. I use 2km because I have multiple locations I'm stationed at.
				if distanceFromWork < 2000 then
					# Pull up work perspective
					my conditions("Work")
					return
				end if
			end try
			
			# Flagged
			set nFlagged to count (every available task of every flattened context whose flagged is true)
			if (nFlagged) > 0 then
				my conditions("Flagged")
				return
			end if
			
			# Routines
			set nRoutines to count (every available task of every flattened context where name of containing project's folder = "Routines")
			if nRoutines > 0 then
				my conditions("Routines")
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
