JsOsaDAS1.001.00bplist00�Vscript_�function run() {
	of = Library('OmniFocus')
	safari = Application('Safari')

	safari.windows[0].tabs().forEach(function(tab) {
		of.parse(tab.name() + ' //' + tab.url())
	})
}                            � jscr  ��ޭ