of = Library('OmniFocus')
sel = of.selected()

sel.forEach(function(task) {
  str = task.name().replace(/\s\(.+\)/, "")
	task.name = str
});
