define [
	'modules/header/init'
	'modules/sample/init'
	'app.framework'
	'communication-bus'
], (HeaderModule, SampleModule, Framework, CommunicationBus) ->

	# Instanciate application
	App = new Framework.Application()

	# Define app regions (found on base HTML)
	App.addRegions
		headerRegion: "#header-region"
		contentRegion: "#content-region"

	# Set default region. It will be used by controllers if they don't
	# get a region on instantiation
	App.setDefaultRegion App.contentRegion

	# This initializer will execute on App.start() (look main.coffee)
	App.addInitializer ->
		new HeaderModule region : App.headerRegion
		new SampleModule

	# Return App object (because this is a RequireJS module)
	return App