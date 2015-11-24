# OmniFocusLibrary.js

You'll need to compile `OmniFocusLibrary.js` as `OmniFocus.scpt` and save it to `~/Library/Script Libraries` so that you can import it other scripts.

- [Download the pre-compiled library.](http://pixelsnatch.com/omnifocus/OmniFocus.scpt)

- [API documentation is available here.](http://pixelsnatch.com/omnifocus/doc/index.html)

- [Source code is available on Github.](http://github.com/brandonpittman/omnifocus)

## Basic Usage

~~~javascript
// An example of how to use OmniFocusLibrary.js

of = Library('OmniFocus')
codingTasks = of.tasksWithContext('coding')
today = new Date
today.setHours(17)
of.setDefer(codingTasks, today)

// Using the parse method

of.parse('Do something! @home ::misc #4pm #tomorrow //This is a note')

// Iterating on selected tasks

sel = of.selected()

sel.forEach(function(task) {
    console.log(task.name())
})
~~~

For the most up-to-date documentation, please check the jsdoc inside `/doc`.

## Transport Text

For those who don't know about transport text, it's a format that OmniFocus uses to parse task information like so:

`Do something! @home ::misc #5pm #tomorrow //This is a note`

The `!` makes `Do something` a flagged task. `@home` sets the context to "home". `::` is used for matching a project. Both `@` and `::` will fuzzy match existing contexts and projects. The first `#` is used for a defer date, while the second `#` is for a due date. Both support natural language parsing like the inspector in OmniFocus. Word of caution though, if only one `#` is present, OmniFocus assumes it's a due date. Lastly, `//` starts the note for a task. While more involved ways of creating OmniFocus tasks exist in the library, you'll find using `of.parse` as your primary means of creating tasks.
