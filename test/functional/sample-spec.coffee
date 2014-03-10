url = 'http://localhost:3000/dist/'

casper.test.begin "Sample integration spec", (test) ->
	casper.start url, ->
		test.assertVisible "#app-region", "#app-region is visible"
		test.assertSelectorHasText "#app-region", "Lorem ipsum"

	casper.run ->
		test.done()
