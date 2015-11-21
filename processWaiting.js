of = Library('OmniFocus')
sel = of.selected()
app = Application('OmniFocus')
app.includeStandardAdditions = true
moment = Library('Moment')
String = Library('String')
date = new RegExp(moment.format("YYYY-MM-DD"))
match = /(\(\d\d\d\d-\d\d-\d\d → )(.+)\) Waiting for response from (.+)/

tasks = app.defaultDocument().flattenedContexts.whose({name: "Waiting"})[0].tasks()

tasks.forEach(function(task) {
  data = task.name().match(match)

  if (data) {
    metaDate = data[1]
    metaAction = data[2]
    metaTask = data[3]

    scheduledForToday = metaDate.match(date)

    if (scheduledForToday) {
      console.log('Scheduled for today!')
      console.log(metaDate)
      console.log(metaAction)
      console.log(metaTask)
      task.name = String.toTitleCase(metaAction) + ' ' + metaTask
      switch (metaAction) {
        case "CALL":
          of.setContext([task], "Calls")
          break
        case "EMAIL":
          of.setContext([task], "Email")
          break
        case "DROP":
          console.log("Deleting task…")
          task.delete()
          break
        default:
          console.log("Not formatted correctly")
      }
    } else { console.log("No match") }
  }
});
