define [
	'app.framework'
	'modules/header/init'
	'modules/sample/init'
	'modules/other/init'
], (Framework, HeaderRegion, SampleRegion, OtherRegion) ->

	App = new Framework.Application

	App.addRegions
		headerRegion: "#header-region"
		contentRegion: "#content-region"

	App.setDefaultRegion App.contentRegion

	App.addInitializer ->
		new HeaderRegion App.headerRegion
		new SampleRegion
		new OtherRegion

	return App