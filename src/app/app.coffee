@App = do (Backbone, Marionette) ->

	App = new Marionette.Application

	App.addRegions
		appRegion: "#app-region"

	App.rootRoute = "sample"

	App.reqres.setHandler "default:region", ->
		return App.appRegion

	App.addInitializer ->
		console.log "App initializer!"

	return App
