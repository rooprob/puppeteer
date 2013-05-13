define [
	'modules/sample/controllers/first-controller'
	'modules/sample/controllers/second-controller'
	'modules/sample/controllers/third-controller'
	'app.framework'
	'communication-bus'
	'modules/other/init'
], (FirstController, SecondController, ThirdController, Framework, CommunicationBus) ->

	class SampleModule extends Framework.Module
		commands:
			"module:sample:first-controller:start": -> new FirstController
			"module:sample:second-controller:start": -> new SecondController
			"module:sample:third-controller:start": -> new ThirdController

		initialize: ->
			new Framework.AppRouter
				routes:
					"": => @startController "first-controller"
					"sample/second": => @startController "second-controller"

		startController: (controller) ->
			CommunicationBus.commands.execute "module:sample:#{controller}:start"
			CommunicationBus.vent.trigger "module:sample:selected"

	CommunicationBus.commands.setHandler "module:sample:start", (region) ->
		new SampleModule region: region