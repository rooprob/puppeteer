define [
	'modules/header/init'
	'modules/sample/init'
	'app.framework'
	'communication-bus'
], (HeaderModule, SampleModule, Framework, CommunicationBus) ->

	App = new Framework.Application()

	App.addRegions
		headerRegion: "#header-region"
		contentRegion: "#content-region"

	App.setDefaultRegion App.contentRegion

	App.addInitializer ->
		new HeaderModule region : App.headerRegion
		new SampleModule

	return App