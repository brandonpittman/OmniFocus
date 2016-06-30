function main(argv) {
	of = Library('OmniFocus')
	sel = of.selected()
	chrono = Library("Chrono")
	date = chrono.parseDate(argv)

	sel.forEach(function(task) {
		task.containingProject().deferDate = date
	});
}

function run(argv) {
  main(argv)
}

function handle_string(argv) {
  main(argv)
}
