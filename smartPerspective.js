var of = Library('OmniFocus');
var app = Application('OmniFocus');
app.includeStandardAdditions = true;
var doc = app.defaultDocument;

function openPerspective(perName) {
	var window = app.windows[0];
	if (window.visible()) {
		window.perspectiveName = perName;
	} else {

	}
	app.activate();
}

var inboxCount = doc.inboxTasks.length;
var firstCount = of.getContext('First Thing').availableTaskCount();
var flaggedCount = doc.flattenedTasks.whose({completed: false, flagged: true, blocked: false}).length;

if (inboxCount > 0) {
	openPerspective("Inbox");
}	else if (firstCount > 0) {
	openPerspective('First Thing');
} else if (flaggedCount > 0) {
	openPerspective("Flagged");
} else {
	openPerspective("Forecast");
}
