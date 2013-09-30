(*
Sticky Focus 2.0
 
This script will take the selected tasks (or projects as well) in OmniFocus and create indiviual reminders in Sticky Notifications. Feel free to change the "title" part of the URL from "OmniFocus" to whatever you like.
 
Copyright 2012 -- [Brandon Pittman](http://brandonpittman.net)

(updates: works from OmniFocus toolbar; preserves prior text item delimiters; proper caps for OmniFocus :) -[dan](http://bylr.net/3/))
*)

tell application "OmniFocus"
	set theWindow to front document window of front document
	set theTasks to selected trees of content of theWindow
	set theValues to {}
	repeat with n in theTasks
		set end of theValues to value of n
	end repeat
	repeat with singleTask in theValues
		set ti to name of singleTask
		my urlEncode(ti)
		tell application "System Events" to open location "sticky-notifications://note?title=OmniFocus&message=" & ti
		set completed of singleTask to true
	end repeat
	activate
end tell

on urlEncode(str)
	local str
	try
		return (do shell script "/bin/echo " & quoted form of str & Â
			" | perl -MURI::Escape -lne 'print uri_escape($_)'")
	on error eMsg number eNum
		error "Can't urlEncode: " & eMsg number eNum
	end try
end urlEncode