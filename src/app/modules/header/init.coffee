define [
	'modules/header/controllers/show-controller'
	'app.framework'
	'communication-bus'
], (ShowController, Framework, Bus) ->

	class HeaderModule extends Framework.Module

		initialize: (region) ->
			new ShowController region: region

	return HeaderModule