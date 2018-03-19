use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
use application "OmniFocus"
property NSString : a reference to current application's NSString
property NSRegularExpressionSearch : a reference to 1024
use framework "Foundation"

property creator : "Brandon Pittman"
property thanks : "Thank you for downloading my OmniFocus library."
property doc : a reference to default document
property DEFER_DAILY : {recurrence:"FREQ=DAILY;INTERVAL=1", repetition method:start after completion}
property DEFER_WEEKLY : {recurrence:"FREQ=WEEKLY;INTERVAL=1", repetition method:start after completion}
property DEFER_MONTHLY : {recurrence:"FREQ=MONTHLY;INTERVAL=1", repetition method:start after completion}
property REPEAT_DAILY : {recurrence:"FREQ=DAILY;INTERVAL=1", repetition method:fixed repetition}
property REPEAT_WEEKLY : {recurrence:"FREQ=WEEKLY;INTERVAL=1", repetition method:fixed repetition}
property REPEAT_MONTHLY : {recurrence:"FREQ=MONTHLY;INTERVAL=1", repetition method:fixed repetition}

--» functions
on selectedItems()
	set theWindow to front document window of front document of application "OmniFocus"
	set contentTasks to selected trees of content of theWindow
	if length of contentTasks > 0 then
		set theTasks to contentTasks
	else
		set sidebarTasks to selected trees of sidebar of theWindow
		set theTasks to sidebarTasks
	end if
	set theValues to {}
	repeat with n in theTasks
		set end of theValues to value of n
	end repeat
	return theValues
end selectedItems

on parse(transportText)
	parse tasks into default document with transport text transportText
end parse

--» find
on findContext(contextName)
	first flattened context of default document whose name is contextName and hidden is false
end findContext

on findContextStarts(contextName)
	first flattened context of default document whose name starts with contextName and hidden is false
end findContextStarts

on findContextEnds(contextName)
	first flattened context of default document whose name ends with contextName and hidden is false
end findContextEnds

on findContextContains(contextName)
	first flattened context of default document whose name contains contextName and hidden is false
end findContextContains

on findProject(projectName)
	first flattened project of default document whose name is projectName and completed is false
end findProject

on findProjectStarts(projectName)
	first flattened project of default document whose name starts with projectName and completed is false
end findProjectStarts

on findProjectEnds(projectName)
	first flattened project of default document whose name ends with projectName and completed is false
end findProjectEnds

on findProjectContains(projectName)
	first flattened project of default document whose name contains projectName and completed is false
end findProjectContains

on findFolder(folderName)
	first flattened folder of default document whose name is folderName and hidden is false
end findFolder

on findFolderWithHidden(folderName)
	first flattened folder of default document whose name is folderName
end findFolderWithHidden

on findHiddenFolder(folderName)
	first flattened folder of default document whose name is folderName and hidden is true
end findHiddenFolder

on findFolderStarts(folderName)
	first flattened folder of default document whose name starts with folderName and hidden is false
end findFolderStarts

on findFolderEnds(folderName)
	first flattened folder of default document whose name ends with folderName and hidden is false
end findFolderEnds

on findFolderContains(folderName)
	first flattened folder of default document whose name contains folderName and hidden is false
end findFolderContains

on findTask(taskName)
	first flattened task of default document whose name is taskName and completed is false
end findTask

on findTaskStarts(taskName)
	first flattened task of default document whose name starts with taskName and completed is false
end findTaskStarts

on findTaskEnds(taskName)
	first flattened task of default document whose name ends with taskName and completed is false
end findTaskEnds

on findTaskContains(taskName)
	first flattened task of default document whose name contains taskName and completed is false
end findTaskContains

--» findAll
on findAllContexts(contextName)
	every flattened context of default document whose name is contextName and hidden is false
end findAllContexts

on findAllContextsStarts(contextName)
	every flattened context of default document whose name starts with contextName and hidden is false
end findAllContextsStarts

on findAllContextsEnds(contextName)
	every flattened context of default document whose name ends with contextName and hidden is false
end findAllContextsEnds

on findAllContextsContains(contextName)
	every flattened context of default document whose name contains contextName and hidden is false
end findAllContextsContains

on findAllProjects(projectName)
	every flattened project of default document whose name is projectName and completed is false
end findAllProjects

on findAllProjectsStarts(projectName)
	every flattened project of default document whose name starts with projectName and completed is false
end findAllProjectsStarts

on findAllProjectsEnds(projectName)
	every flattened project of default document whose name ends with projectName and completed is false
end findAllProjectsEnds

on findAllProjectsContains(projectName)
	every flattened project of default document whose name contains projectName and completed is false
end findAllProjectsContains

on findAllProjectsFlagged()
	every flattened project of default document whose completed is false and flagged is true
end findAllProjectsFlagged

on findAllFolders(folderName)
	every flattened folder of default document whose name is folderName and hidden is false
end findAllFolders

on findAllFoldersStarts(folderName)
	every flattened folder of default document whose name starts with folderName and hidden is false
end findAllFoldersStarts

on findAllFoldersEnds(folderName)
	every flattened folder of default document whose name ends with folderName and hidden is false
end findAllFoldersEnds

on findAllFoldersContains(folderName)
	every flattened folder of default document whose name contains folderName and hidden is false
end findAllFoldersContains

on findAllTasks(taskName)
	every flattened task of default document whose name is taskName and completed is false
end findAllTasks

on findAllTasksStarts(taskName)
	every flattened task of default document whose name starts with taskName and completed is false
end findAllTasksStarts

on findAllTasksEnds(taskName)
	every flattened task of default document whose name ends with taskName and completed is false
end findAllTasksEnds

on findAllTasksContains(taskName)
	every flattened task of default document whose name contains taskName and completed is false
end findAllTasksContains

on findAllTasksFlagged()
	every flattened task of default document whose completed is false and flagged is true
end findAllTasksFlagged


--» allSomething
on allTasks()
	every flattened task of default document whose completed is false
end allTasks

on allProjects()
	every flattened project of default document whose completed is false
end allProjects

on allContexts()
	every flattened context of default document whose hidden is false
end allContexts

--» setSomething
on setDue(input, dueDate)
	repeat with _input in flatten(input)
		set due date of _input to dueDate
	end repeat
end setDue

on setDefer(input, deferDate)
	repeat with _input in flatten(input)
		set defer date of _input to deferDate
	end repeat
end setDefer

on setContainer(input, projectInput)
	if class of projectInput is text then
		set theProject to findProject(projectInput)
	else
		set theProject to projectInput
	end if
	repeat with _input in flatten(input)
		set assigned container of _input to theProject
	end repeat
end setContainer

on setContext(input, contextInput)
	if class of contextInput is text then
		set theContext to findContext(contextInput)
	else
		set theContext to contextInput
	end if
	repeat with _input in flatten(input)
		set context of _input to theContext
	end repeat
end setContext

on inboxTasks()
	every inbox task of default document
end inboxTasks

--» prepend & append
on namePrepend(input, prependString)
	repeat with _input in flatten(input)
		set name of _input to prependString & name of _input
	end repeat
end namePrepend

on nameAppend(input, appendString)
	repeat with _input in flatten(input)
		set name of _input to name of _input & appendString
	end repeat
end nameAppend

on setFlagged(input, flag)
	repeat with _input in flatten(input)
		set flagged of _input to flag
	end repeat
end setFlagged

on setComplete(input, flag)
	repeat with _input in flatten(input)
		if flag is true then
			mark complete _input
		else if flag is false then
			mark incomplete _input
		end if
		
	end repeat
end setComplete

on setSequential(input, flag)
	repeat with _input in flatten(input)
		set sequential of _input to flag
	end repeat
end setSequential

on toggleSequential(input)
	repeat with _input in flatten(input)
		set sequential of _input to not (sequential of _input)
	end repeat
end toggleSequential

-->> Creating Flow with OmniFocus

on openPerspective(perspectiveName)
	set perspective name of front window of application "OmniFocus" to perspectiveName
end openPerspective

on inboxCount()
	count inbox tasks of default document
end inboxCount

on errandsCount()
	available task count of findContext("Errands")
end errandsCount

on routineCount()
	set taskCount to 0
	set flattenedProjects to flattened projects of findFolder("Routine")
	repeat with flattenedProject in flattenedProjects
		set taskCount to taskCount + (number of available tasks of flattenedProject)
	end repeat
end routineCount

on landAndSeaCount()
	number of available tasks of findProject("Land & Sea")
end landAndSeaCount

on computerName()
	do shell script "scutil --get ComputerName"
end computerName

# Repetition rules

on setRepeat(input, repetitionRule)
	repeat with _input in flatten(input)
		set repetition rule of _input to repetitionRule
	end repeat
end setRepeat

on deferDaily(input)
	setRepeat(input, DEFER_DAILY)
end deferDaily

on deferWeekly(input)
	setRepeat(input, DEFER_WEEKLY)
end deferWeekly

on deferMonthly(input)
	setRepeat(input, DEFER_MONTHLY)
end deferMonthly

on repeatDaily(input)
	setRepeat(input, REPEAT_DAILY)
end repeatDaily

on repeatWeekly(input)
	setRepeat(input, REPEAT_WEEKLY)
end repeatWeekly

on repeatMonthly(input)
	setRepeat(input, REPEAT_MONTHLY)
end repeatMonthly

--» Clear properties, etc.

on clearRepeat(input)
	setRepeat(input, missing value)
end clearRepeat

on clearContext(input)
	setContext(input, missing value)
end clearContext

on clearContainer(input)
	setContainer(input, missing value)
end clearContainer

on clearDefer(input)
	setDefer(input, missing value)
end clearDefer

on showAbout()
	tell application "System Events"
		tell process "OmniFocus"
			click menu item "About OmniFocus" of menu "OmniFocus" of menu bar item "OmniFocus" of menu bar 1
		end tell
	end tell
end showAbout

on setOnHold(input)
	repeat with i in input
		if class of i is project then set status of i to on hold
	end repeat
end setOnHold

on setActive(input)
	repeat with i in input
		if class of i is project then set status of i to active
	end repeat
end setActive

on setDropped(input)
	repeat with i in input
		if class of i is project then set status of i to dropped
	end repeat
end setDropped

-->> Colonize/Decolonize
on titlecase(sourceString)
	((NSString's stringWithString:sourceString)'s capitalizedString()) as text
end titlecase

on downcase(sourceString)
	((NSString's stringWithString:sourceString)'s lowercaseString()) as text
end downcase

on toggleColon(input)
	repeat with _input in flatten(input)
		set textProperties to {}
		set theText to text of (get name of _input)
		set firstWord to first word of theText
		set firstWordPlusOne to text 1 thru ((length of firstWord) + 1) of theText
		
		if text -1 of firstWordPlusOne is ":" then
			removeColon(_input)
		else
			addColon(_input)
		end if
	end repeat
end toggleColon

on addColon(input)
	set textProperties to {}
	set theText to text of (get name of input)
	set firstWord to first word of theText
	set firstWordPlusOne to text 1 thru ((length of firstWord) + 1) of theText
	
	if text -1 of firstWordPlusOne is not ":" then
		set textProperties to textProperties & {theRest:text -1 thru ((length of firstWord) + 2) of theText}
		set name of input to titlecase(firstWord) & ": " & titlecase(theRest of textProperties)
	end if
end addColon

on removeColon(input)
	set textProperties to {}
	set theText to text of (get name of input)
	set firstWord to first word of theText
	set firstWordPlusOne to text 1 thru ((length of firstWord) + 1) of theText
	
	if text -1 of firstWordPlusOne is ":" then
		set textProperties to textProperties & {theRest:text -1 thru ((length of firstWord) + 3) of theText}
		set name of input to titlecase(firstWord) & " " & titlecase(theRest of textProperties)
	end if
end removeColon

on setColon(input)
	repeat with _input in flatten(input)
		addColon(_input)
	end repeat
end setColon

on clearColon(input)
	repeat with _input in flatten(input)
		removeColon(_input)
	end repeat
end clearColon

on setPrefix(input, prefix)
	set thePrefix to (prefix & ":")
	repeat with _input in flatten(input)
		namePrepend(_input, thePrefix & " ")
	end repeat
end setPrefix

on clearPrefix(input, prefix)
	set thePrefix to (prefix & ": ?")
	repeat with _input in flatten(input)
		set newName to replaceRegex(name of _input, thePrefix, "")
		set name of _input to newName
	end repeat
end clearPrefix

on clearPrefixAll(input)
	set thePrefix to (".+: ?")
	repeat with _input in flatten(input)
		set newName to replaceRegex(name of _input, thePrefix, "")
		set name of _input to newName
	end repeat
end clearPrefixAll

on setConditional(input, conditionalTask)
	setPrefix(input, "If " & conditionalTask)
end setConditional

on clearConditional(input)
	clearPrefixAll(input)
end clearConditional

on toggleConditional(input)
	repeat with _input in flatten(input)
		if first word of (get name of _input) is "If" then
			clearConditional(input)
		else
			set conditionalTask to text returned of (display dialog "If statement…" default answer "")
			setConditional(input, conditionalTask)
		end if
	end repeat
end toggleConditional

on setConsider(input)
	setPrefix(input, "Consider")
	setRepeat(input, DEFER_DAILY)
	setContext(input, (first flattened context whose name starts with "Consider" and hidden is false) of default document)
end setConsider

on clearConsider(input)
	clearPrefix(input, "Consider")
	clearRepeat(input)
	setContext(input, context of parent task of item 1 of input)
end clearConsider

on toggleConsider(input)
	repeat with _input in flatten(input)
		if first word of (get name of _input) is "Consider" then
			clearConsider(_input)
		else
			setConsider(_input)
		end if
	end repeat
end toggleConsider

# Needed for prefix handlers

on replaceRegex(sourceString, theFind, theReplace)
	set aString to NSString's stringWithString:sourceString
	(aString's stringByReplacingOccurrencesOfString:theFind withString:theReplace options:NSRegularExpressionSearch range:{0, aString's |length|()}) as text
end replaceRegex

on kindOf(input)
	using terms from application "OmniFocus"
		if isProject(input) then
			return project
		else if isTask(input) then
			return task
		else if isContext(input) then
			return context
		else if isFolder(input) then
			return folder
		end if
	end using terms from
end kindOf

on isProject(input)
	using terms from application "OmniFocus"
		if class of input is project then
			return true
		else
			return false
		end if
	end using terms from
end isProject

on isContext(input)
	using terms from application "OmniFocus"
		if class of input is context then
			return true
		else
			return false
		end if
	end using terms from
end isContext

on isFolder(input)
	using terms from application "OmniFocus"
		if class of input is folder then
			return true
		else
			return false
		end if
	end using terms from
end isFolder

on isTask(input)
	using terms from application "OmniFocus"
		if class of input is task then
			return true
		else
			return false
		end if
	end using terms from
end isTask

--» Helper Functions
on flatten(aList)
	if class of aList is not list then
		return {aList}
	else if length of aList is 0 then
		return aList
	else
		return flatten(first item of aList) & (flatten(rest of aList))
	end if
end flatten