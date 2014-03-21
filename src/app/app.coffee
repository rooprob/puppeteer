# Creates a global `App` object attached to the
# `window` to namespace our application
@App = do (Backbone, Marionette) ->

	App = new Marionette.Application

	# Adds two App regions, one for the header and
	# one for the content of the application
	App.addRegions
		appRegion: "#app-region"
		headerRegion : "#header-region"

	# Sets the default route. Our application will navigate
	# here if no route is provided on the URL.
	# See: src/app/lib/utilities/navigation.coffee
	App.rootRoute = "muppets"

	# Creates an application global request to return the
	# default region. It will be used, for example, by
	# Controllers trying to show views without an specific
	# region provided.
	# See: src/app/lib/controllers/application-controller.coffee
	App.reqres.setHandler "default:region", ->
		return App.appRegion

	# On application start, we want to start the HeaderModule.
	# We could have opted to use Marionette's Modules auto-start
	# feature, but we chose to prevent it on HeaderModule as seen
	# in: http://goo.gl/KuR2EV
	# We did this in order to give HeaderModule a reference to the
	# `headerRegion`, where the views of the module will be rendered
	App.addInitializer ->
		App.HeaderModule.start
			region: App.headerRegion

	return App
