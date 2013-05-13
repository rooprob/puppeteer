define [
	'modules/other/controllers/show-controller'
	'app.framework'
	'communication-bus'
], (ShowController, Framework, CommunicationBus) ->

	class OtherModule extends Framework.Module
		commands:
			"module:other:show-controller:start": -> new ShowController

		initialize: ->
			new Framework.AppRouter
				routes:
					"other": => @startController "show-controller"

		startController: (controller) ->
			CommunicationBus.commands.execute "module:other:#{controller}:start"
			CommunicationBus.vent.trigger "module:other:selected"

	CommunicationBus.commands.setHandler "module:other:start", (region) ->
		new OtherModule region: region