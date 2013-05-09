define [
	'modules/header/controllers/show-controller'
	'app.framework'
	'communication-bus'
], (ShowController, Framework, CommunicationBus) ->

	class HeaderModule extends Framework.Module
		initialize: (options = {}) ->
			new ShowController region: options.region

	return HeaderModule