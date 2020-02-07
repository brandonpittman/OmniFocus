# OmniFocus Library

*Notice: Probably any script in this repo will require this library. Assume you need it.*

## Why is there a new OmniFocus library?

I had previously written an OmniFocus library using JavaScript for Automation, but it's got issues that vanilla AppleScript does not. Also, I realized that I didn't really need the fancy regex abilities from JavaScript that I thought I needed, so I went back to standard AppleScript. It works just as well, and the source code is a lot more readable. I hope you find this new library useful.

- **[Download the library](https://github.com/brandonpittman/OmniFocus/blob/master/OmniFocus%20Library/omnifocus.scpt?raw=true)**
- **[Browse the repo Github](https://github.com/brandonpittman/OmniFocus)**

## Basic Usage

Put *omnifocus.scpt* in `~/Library/Script Libraries`, or else AppleScript won't know where to find it!

~~~applescript
use application "OmniFocus"
use O : script "omnifocus"

tell O
   set sel to selectedItems()
   deferDaily(sel)  # this will set all the selected tasks to start again after completion daily
   setDefer(sel, current date)

   set theTask to findTask("Log food") # find the first task whose name is "Log food"
   set theProject to findProject("Groceries")
   set theContext to findContext("Home")
   set theFolder to findFolder("Routine")

   # Parse using transport text (see below for details)
   parse("Do something! @home ::misc #5pm #tomorrow //This is a note")
end
~~~

## Transport Text

For those who don't know about transport text, it's a format that OmniFocus uses to parse task information like so:

`Do something! @home ::misc #5pm #tomorrow //This is a note`

The `!` makes `Do something` a flagged task. `@home` sets the context to "home". `::` is used for matching a project. Both `@` and `::` will fuzzy match existing contexts and projects. The first `#` is used for a defer date, while the second `#` is for a due date. Both support natural language parsing like the inspector in OmniFocus. Word of caution though, if only one `#` is present, OmniFocus assumes it's a due date. Lastly, `//` starts the note for a task. While more involved ways of creating OmniFocus tasks exist in the library, you'll find using `of.parse` as your primary means of creating tasks.

## Functions

- selectedItems()
- parse(transportText)
- findContext(contextName)
- findProject(projectName)
- findFolder(folderName)
- findTask(taskName)
- allTasks()
- allProjects()
- allContexts()
- setDue(input, dueDate)
- setDefer(input, deferDate)
- setProject(input, projectName)
- setContext(input, contextName)
- namePrepend(input, prependString)
- nameAppend(input, appendString)
- inboxTasks()
- setComplete(input, booleanFlag)
- setSequential(input, booleanFlag)
- openPerspective(perspectiveName)
- inboxCount()
- errandsCount()
- landAndSeaCount()
- routineCount()
- computerName()
- setRepeat(input, repetitionRule)
- deferDaily(input)
- deferWeekly(input)
- deferMonthly(input)
- repeatDaily(input)
- repeatWeekly(input)
- repeatMonthly(input)
- clearRepeat(input)
- clearDefer(input)
- clearContainer(input) *Only works on inbox tasks.*
- clearContext(input)
- setOnHold(input)
- setActive(input)
- showAbout()
- toggleColon(input)
- setColon(input)
- clearColon(input)
- setPrefix(input, prefix)
- clearPrefix(input, prefix)
- clearPrefixAll(input)
- setConsider(input)
- clearConsider(input)
- toggleConsider(input)
- kindOf(input) *This will be a task, project, context or folder.*
- isProject(input)
- isContext(input)
- isTask(input)
- isFolder(input)

<a href="https://www.buymeacoffee.com/blp" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-blue.png" alt="Buy Me A Coffee" style="height: 51px !important;width: 217px !important;" ></a>
