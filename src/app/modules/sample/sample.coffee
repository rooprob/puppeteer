@App.module "SampleModule", (SampleModule, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class SampleModule.Router extends Marionette.AppRouter
		appRoutes:
			"sample/trololo" : "trololo"
			"sample" : "list"

	API =
		trololo: ->
			new SampleModule.Trololo.Controller
		list: ->
			new SampleModule.List.Controller

	App.addInitializer ->
		new SampleModule.Router
			controller: API
