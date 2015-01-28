var of = Library('OmniFocus');

if (of.inboxCount() > 0) {
  of.openPerspective("Inbox");
}	else if (of.firstCount() > 0) {
	of.openPerspective('First Thing');
} else if (of.flaggedCount() > 0) {
	of.openPerspective("Flagged");
} else {
	of.openPerspective("Upcoming");
}
