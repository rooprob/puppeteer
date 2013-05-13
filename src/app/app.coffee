define [
	'app.framework'
	'communication-bus'
	'modules/header/init'
	'modules/sample/init'
	'modules/other/init'
], (Framework, CommunicationBus) ->

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
		CommunicationBus.commands.execute "module:header:start", App.headerRegion
		CommunicationBus.commands.execute "module:sample:start"
		CommunicationBus.commands.execute "module:other:start"

	# Return App object (because this is a RequireJS module)
	return App