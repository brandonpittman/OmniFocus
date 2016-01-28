// I've stopped using this script as of 2016-01-28. It served me well over the
// last couple years, but I've decided that it's much better to consciously
// decided what it is that you want to be looking at at any given moment—rather
// than letting the computer decide what MODE you should be in.

var of = Library("OmniFocus");

if (of.inboxCount() > 0) {
  of.openPerspective("Inbox")
}	else if (of.firstCount() > 0) {
  of.openPerspective("First Thing")
} else if (of.flaggedCount() > 0) {
  of.openPerspective("Flagged")
} else {
  of.openPerspective("Upcoming")
}
