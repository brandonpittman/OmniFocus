function main(argv) {
  of = Library('OmniFocus')
	sel = of.selected()
	app = Application('OmniFocus')
	app.includeStandardAdditions = true
	chrono = Library("Chrono")
	moment = Library('Moment')

	
	of.setContext(sel, "Waiting for...")
	
	sel.forEach(function(task) {
  	matchData = task.name().match(/(.+?) (.+)/)
		metaAction = matchData[1].toUpperCase()
		metaName = matchData[2]
		rightArrow = " → "
		metaMessage = "Waiting for response from " + metaName
		args = argv.split('')
		possibleDrop = args.slice(0,4).join('').match(/drop/i)
		if (argv.match(/^\d+$/)) {
			numberOfDays = args.join()
			metaWhen = chrono.parseDate("in " + argv + " days")
		} else if (possibleDrop) {
			if (args[5].match(/\b\d\b/)) {
				numberOfDays = args[5]
				metaWhen = chrono.parseDate("in " + numberOfDays + " days")
			} else {
				metaWhen = chrono.parseDate(args.slice(5,args.length).join(""))
			}
			metaDate = moment.format("YYYY-MM-DD", metaWhen)
			
			task.name = "(" + metaDate + rightArrow + "DROP) " + metaMessage
			return
		} else {
			metaWhen = chrono.parseDate(args.slice(0,args.length).join(""))
		}
		metaDate = moment.format("YYYY-MM-DD", metaWhen)
		task.name = "(" + metaDate + rightArrow + metaAction + ") " + metaMessage
	});
}

function run(argv) {
  main(argv)
}

function handle_string(argv) {
  main(argv)
}
