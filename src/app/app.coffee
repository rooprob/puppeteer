define [
	'app.framework'
	'communication-bus'
	'modules/header/init'
	'modules/sample/init'
	'modules/other/init'
], (Framework, CommunicationBus) ->

	App = new Framework.Application()

	App.addRegions
		headerRegion: "#header-region"
		contentRegion: "#content-region"

	App.setDefaultRegion App.contentRegion

	App.addInitializer ->
		CommunicationBus.commands.execute "module:header:start", App.headerRegion
		CommunicationBus.commands.execute "module:sample:start"
		CommunicationBus.commands.execute "module:other:start"

	return App