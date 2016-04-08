of = Library('Omnifocus')
sel = of.selected()
app = Application('OmniFocus')
app.includeStandardAdditions = true
system = Application.currentApplication()
system.includeStandardAdditions = true

sel.forEach(function(task) {
	of.complete([task])
	name = task.name()
	note = task.note()
	quote = '"'
	urlRegExp = new RegExp('://')
	if (note.match(urlRegExp)) {
		console.log(note)
		system.doShellScript("open " + quote + note + quote)
		return true
	};
})
