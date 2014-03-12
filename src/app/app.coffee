@App = do (Backbone, Marionette) ->

	App = new Marionette.Application

	App.addRegions
		appRegion: "#app-region"
		headerRegion : "#header-region"

	App.rootRoute = "muppets"

	App.reqres.setHandler "default:region", ->
		return App.appRegion

	App.addInitializer ->
		App.HeaderModule.start
			region: App.headerRegion

	return App
