# OFL

## Why is there a new OmniFocus library?

I had previously written an OmniFocus library using JavaScript for Automation, but it's got issues that vanilla AppleScript does not. Also, I realized that I didn't really need the fancy regex abilities from JavaScript that I thought I needed, so I went back to standard AppleScript. It works just as well, and the source code is a lot more readable. I hope you find this new library useful.

**[Source code is available on Github.](https://github.com/brandonpittman/OmniFocus/blob/master/OFL.scpt?raw=true)**

## Basic Usage

~~~applescript
use application "OmniFocus"
use OFL : script "OFL"

tell OFL
    set sel to selection()
    deferDaily(sel)  # this will set all the selected tasks to start again after completion daily
    setDefer(sel, current date)

   set theTask to findTask("Log food") # find the first task whose name is "Log food"
   set theProject to findProject("Groceries")
   set theContext to findContext("Home")
   set theFolder to findFolder("Routine")

   parse("Do something! @home ::misc #5pm #tomorrow //This is a note") # Parse using transport text (see below for details)
end
~~~

## Transport Text

For those who don't know about transport text, it's a format that OmniFocus uses to parse task information like so:

`Do something! @home ::misc #5pm #tomorrow //This is a note`

The `!` makes `Do something` a flagged task. `@home` sets the context to "home". `::` is used for matching a project. Both `@` and `::` will fuzzy match existing contexts and projects. The first `#` is used for a defer date, while the second `#` is for a due date. Both support natural language parsing like the inspector in OmniFocus. Word of caution though, if only one `#` is present, OmniFocus assumes it's a due date. Lastly, `//` starts the note for a task. While more involved ways of creating OmniFocus tasks exist in the library, you'll find using `of.parse` as your primary means of creating tasks.
