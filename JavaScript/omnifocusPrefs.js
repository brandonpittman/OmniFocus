var current = Application.currentApplication();
current.includeStandardAdditions = true;

var preferences = {
	'Standard Layout': 'ContentLayout',
	'Compact Layout': 'ContentLayout=compact',
	'Hide Empty Contexts': 'MainOutlineIncludesEmptyContexts=false',
	'Show Empty Contexts': 'MainOutlineIncludesEmptyContexts=true',
	'Hide On Hold Projects in Forecast': 'ForecastIncludesProjectsOnHold=false',
	'Show On Hold Projects in Forecast': 'ForecastIncludesProjectsOnHold=true',
	'Clip to Inbox': 'ClippingsGoToQuickEntry=false',
	'Clip to Quick Entry': 'ClippingsGoToQuickEntry=true',
	'Graphite Toolbar': 'ToolbarItemTint=graphite',
	'Aqua Toolbar': 'ToolbarItemTint=aqua',
	'Forecast Drag Sets Defer Date': 'ForecastDragSetsDeferDate=true',
	'Forecast Drag Sets Due Date': 'ForecastDragSetsDeferDate=false'
};

var choices = current.chooseFromList([
	'Standard Layout',
	'Compact Layout',
	'Hide Empty Contexts',
	'Show Empty Contexts',
	'Hide On Hold Projects in Forecast',
	'Show On Hold Projects in Forecast',
	'Clip to Inbox',
	'Clip to Quick Entry',
	'Graphite Toolbar',
	'Aqua Toolbar',
	'Forecast Drag Sets Defer Date',
	'Forecast Drag Sets Due Date'
], {withTitle: "OmniFocus Preferences", multipleSelectionsAllowed: true});

choices.forEach(function(choice) {
	change(preferences[choice]);
	delay(.1);
})

function change(preference) {
	current.doShellScript("open 'omnifocus:///change-preference?" + preference + "'");
}
