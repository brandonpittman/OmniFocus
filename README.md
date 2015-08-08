# OmniFocusLibrary.js

You'll need to compile this as `OmniFocus.scpt` and save it at `~/Library/Script Libraries` so that you can import it in another script.

- [Download the pre-compiled library.](http://pixelsnatch.com/omnifocus/OmniFocus.scpt)

- [API documentation is available here.](http://pixelsnatch.com/omnifocus/doc/index.html)

- [Source code is available on Github.](http://github.com/brandonpittman/omnifocus)

## Usage

~~~javascript
// An example of how to use OmniFocusLibrary.js

of = Library('OmniFocus')
codingTasks = of.tasksWithContext('coding')
today = new Date
today.setHours(17)
of.setDefer(codingTasks, today)

// Using the parse method

of.parse('Do something! @home ::misc #4pm #tomorrow //This is a note')
~~~

## Available functions

- `alert(text)` — display AppleScript alert dialog
- `allTasks()` — all tasks in your default document
- `allProjects()` — all projects in your default document
- `copy(text)` — copies text to OS X's clipboard
- `tasksWithName(name, inputTasks)` — all tasks that fuzzy match `name` — `inputTasks` defaults to `allTasks`
- `tasksWithContext(name, inputTasks)` — all tasks that have a context that fuzzy match `name` — `inputTasks` defaults to `allTasks`
- `projectsWithName(name, inputProjects)` — all projects that fuzzy match `name` — `inputProjects` defaults to `allProjects`
- `allWithName(name)` — all tasks that fuzzy match `name` with a task title, context or containing project
- `setDefer(tasks, deferDate)` — defer an array of tasks with `deferDate`
- `setDue(tasks, dueDate)` — set an array of tasks' due date with `dueDate`
- `setContext(tasks, contextName)` — set an array of tasks' context to `contextName`
- `inboxTasks()` — all inbox tasks
- `getContext(contextName)` — gets the first context object that matches `contextName`
- `getProject(projectName)` — gets the first project object that matches `projectName`
- `newTask(text, place, deferDate, dueDate)` — creates a new OmniFocus task object
- `parse(text)` — parse a string of transport text as a task
- `pushTask(task, project)` — push `task` to `project` array
- `prefixTasksWith(tasks,text)` — prefix each task in `tasks` with `text`
- `updateInboxTasks(context, project, deferDate, dueDate)` — update all inbox tasks with the same `context`, `deferDate`, and `dueDate` and add them to `project`

## Transport Text

For those who don't know about transport text, it's a format that OmniFocus uses to parse task information like so:

`Do something! @home ::misc #5pm #tomrrow //This is a note`

The `!` makes `Do something` a flagged task. `@home` sets the context to "home". `::` is used for matching a project. Both `@` and `::` will fuzzy match existing contexts and projects. The first `#` is used for a defer date, while the second `#` is for a due date. Both support natural language parsing like the inspector in OmniFocus. Word of caution though, if only one `#` is present, OmniFocus assumes it's a due date. Lastly, `//` starts the note for a task.
