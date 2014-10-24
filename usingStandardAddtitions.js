app = Application.currentApplication()
app.includeStandardAdditions = true
answer = app.displayDialog("What's your name?", {withTitle: "Name Sayer 3000", defaultAnswer: ""})
app.say("Hello, " + answer.textReturned)
