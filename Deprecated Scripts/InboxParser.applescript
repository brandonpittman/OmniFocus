of = Library('OmniFocus')
app = Application('OmniFocus')
app.includeStandardAdditions = true

app.defaultDocument.inboxTasks().forEach(function(task) {
	if (task.name().match(/@|::|#/)){
		of.parse(task.name())
		app.delete(task)
	}
})