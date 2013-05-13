define [
	'modules/header/controllers/show-controller'
	'app.framework'
	'communication-bus'
], (ShowController, Framework, CommunicationBus) ->

	class HeaderModule extends Framework.Module

		initialize: (region) ->
			new ShowController region: region

	CommunicationBus.commands.setHandler "module:header:start", (region) ->
		new HeaderModule region