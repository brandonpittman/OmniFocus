function main(argv) {
  var of = Library('OmniFocus');
	var sel = of.selected();
	var app = Application('OmniFocus');
	app.includeStandardAdditions = true;
	var chrono = Library("Chrono");
	var moment = Library('Moment');

	of.setContext(sel, "Waiting");

	sel.forEach(function(task) {
  	var matchData = task.name().match(/(.+?) (.+)/);
		var metaAction = matchData[1].toUpperCase();
		var metaName = matchData[2];
		var rightArrow = " → ";;
		var metaMessage = "Waiting for response from " + metaName;
		var args = argv.split('');
		var possibleDrop = args.slice(0,4).join('').match(/drop/i);
		if (args[0].match(/\d/)) {
			var numberOfDays = args[0];
			var metaWhen = chrono.parseDate("in " + numberOfDays + " days");
		} else if (possibleDrop) {
			if (args[5].match(/\d/)) {
				var numberOfDays = args[5];
				var metaWhen = chrono.parseDate("in " + numberOfDays + " days");
			} else {
				metaWhen = chrono.parseDate(args.slice(5,args.length).join(""));
			}
			var metaDate = moment.format("YYYY-MM-DD", metaWhen);

			task.name = "(" + metaDate + rightArrow + "DROP) " + metaMessage;
			var return;
		} else {
			var metaWhen = chrono.parseDate(args.slice(0,args.length).join(""));
		}
		var metaDate = moment.format("YYYY-MM-DD", metaWhen);
		task.name = "(" + metaDate + rightArrow + metaAction + ") " + metaMessage;
	});
}

function run(argv) {
  main(argv)
}

function handle_string(argv) {
  main(argv)
}
