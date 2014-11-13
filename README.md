# OmniFocus Scripts

## OmniFocusLibrary.js
You'll need to compile this as `OmniFocus.scpt` and save it at `~/Library/Script Libraries` so that you can import it in another script.

## Usage

```javascript
// OmniFocusLibrary.js

// create OmniFocusLibrary object
of = Library('OmniFocus')

// create array of tasks belonging to the 'coding' context
codingTasks = of.tasksWithContext('coding')
// create some date objects
today = new Date
today.setHours(17)
// defer each task in the array
of.setDefer(codingTasks, today)

// quickly create an OmniFocus task using transport text 
of.parse('Do something! @home ::misc #5pm #tomorrow //This is a note')

```

## Caveats

I intended to include natural language date parsing in this script, and I've been trying to get the [chrono](https://github.com/wanasit/chrono) library to work in my OmniFocus library, but to no avail. Anyone willing to help with this would have my deepest thanks. As it stands, you need to pass a date object into any function that deals with setting deferDate or dueDate.

## Other OmniFocus & AppleScript Projects

### regexDefer.js

`Usage: osascript -l JavaScript 'something' 'next Saturday'`

### SmartMorning.js

Smartly defer a task to 8AM of the **next business day**.

### StickyFocus.applescript
Handy AppleScript for creating [Sticky Notifications](http://instinctivecode.com/sticky-notifications/) from OmniFocus tasks. The script will take any selected project or task in OmniFocus and create a Sticky Notification using the Sticky Notification URL scheme.

### SmartPerspective.applescript

Handy AppleScript for smartly opening the perspective you *should* be looking at.

### Birthdays2OmniFocus

Create a "Birthdays" project in OmniFocus and create birthday reminders for each person with a birthday assigned in your OS X Contacts.app.
