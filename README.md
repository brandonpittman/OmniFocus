OmniFocus
===========

## OmniFocusLibrary.js

You'll need to compile this as `OmniFocus.scpt` and save it at `~/Library/Script Libraries` so that you can import it in another script.

### Usage

```javascript
of = Library('OmniFocus')

codingTasks = of.tasksWithContext('coding')
today = new Date
today.setHours(17)
of.setDefer(codingTasks, today)

```

### Caveats

I intended to include natural language date parsing in this script, and I've been trying to get the **chrono** library to work in my OmniFocus library, but to no avail. Anyone willing to help with this would have my deepest thanks. As it stands, you need to pass a date object into any function that deals with setting deferDate or dueDate.

### Available functions

- `allTasks()` — all tasks in your default document
- `allProjects()` — all projects in your default document
- `tasksWithName(name)` — all tasks that fuzzy match `name`
- `tasksWithContext(name)` — all tasks that have a context that fuzzy match `name`
- `projectsWithName(name)` — all projects that fuzzy match `name`
- `allWithName(name)` — all tasks that fuzzy match `name` with a task title, context or containing project
- `setDefer(tasks, deferDate)` — defer an array of tasks with `deferDate`
- `setDue(tasks, dueDate)` — set an array of tasks' due date with `dueDate`
- `setContext(tasks, contextName)` — set an array of tasks' context to `contextName`
- `inboxTasks()` — all inbox tasks
- `getContext(contextName)` — gets the first context object that matches `contextName`
- `getProject(projectName)` — gets the first project object that matches `projectName`
- `newTask(text, place, deferDate, dueDate)` — creates a new OmniFocus task object
- `pushTask(task, project)` — push `task` to `project` array
- `prefixTasksWith(tasks,text)` — prefix each task in `tasks` with `text`
- `updateInboxTasks(context, project, deferDate, dueDate)` — update all inbox tasks with the same `context`, `deferDate`, and `dueDate` and add them to `project`

## regexDefer.js

`Usage: osascript -l JavaScript 'something' 'next Saturday'`

## SmartMorning.js

Smartly defer a task to 8AM of the **next business day**.

## StickyFocus.applescript
Handy AppleScript for creating [Sticky Notifications](http://instinctivecode.com/sticky-notifications/) from OmniFocus tasks. The script will take any selected project or task in OmniFocus and create a Sticky Notification using the Sticky Notification URL scheme.

## SmartPerspective.applescript

Handy AppleScript for smartly opening the perspective you *should* be looking at.

## Birthdays2OmniFocus

Create a "Birthdays" project in OmniFocus and create birthday reminders for each person with a birthday assigned in your OS X Contacts.app.

*Release Notes (1.0)*

This is the 1.0 push. It works well for adding the initial birthday reminders. It will create the "Birthdays" project if it doesn't already exist. It references a "Communications" perspective but doesn't create it as of now. You can run it later on to update the project with new birthday reminders and it checks if each birthday already exists in OmniFocus. I'm not totally sure why, but it will occasionally go wonky and create multiple entries.
