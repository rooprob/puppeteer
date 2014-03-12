@App.module "HeaderModule", (HeaderModule, App, Backbone, Marionette, $, _) ->

	@startWithParent = false

	API =
		list: ->
			new HeaderModule.Show.Controller
				region: App.headerRegion

	App.addInitializer ->
		API.list()
