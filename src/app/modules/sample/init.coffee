define [
	'modules/sample/controllers/first-controller'
	'modules/sample/controllers/second-controller'
	'modules/sample/controllers/third-controller'
	'app.framework'
	'communication-bus'
], (FirstController, SecondController, ThirdController, Framework, Bus) ->

	class SampleModule extends Framework.Module

		initialize: ->
			@setCommands
				"module:sample:first:start": -> new FirstController
				"module:sample:second:start": -> new SecondController
				"module:sample:third:start": -> new ThirdController

			new Framework.AppRouter
				routes:
					"": => @startController "first"
					"sample/second": => @startController "second"

		startController: (controller) ->
			Bus.commands.execute "module:sample:#{controller}:start"
			Bus.vent.trigger "module:sample:selected"

	return SampleModule