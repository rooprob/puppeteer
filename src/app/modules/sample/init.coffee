define [
	'modules/sample/controllers/first-controller'
	'modules/sample/controllers/second-controller'
	'modules/sample/controllers/third-controller'
	'app.framework'
	'communication-bus'
	'modules/other/init'
], (FirstController, SecondController, ThirdController, Framework, CommunicationBus) ->

	# Define SampleModule class
	class SampleModule extends Framework.Module

		# This initialize method will execute on instantiation of this class
		initialize: (options = {}) ->
			# Instantiate a new Framework.AppRouter.
			# The router will manage association between URLs and actions.
			new Framework.AppRouter
				routes:
					"": => @startController "first-controller"
					"sample/second": => @startController "second-controller"

		# Attach command handlers
		commands:
			"module:sample:first-controller:start": -> new FirstController
			"module:sample:second-controller:start": -> new SecondController
			"module:sample:third-controller:start": -> new ThirdController

		# Start given controller, triggering a "module selected" event
		# which, for this sample, will be used on HeaderModule to mark
		# active navigation link
		startController: (controller) ->
			CommunicationBus.commands.execute "module:sample:#{controller}:start"
			CommunicationBus.vent.trigger "module:sample:selected"

	# Register Module's start command
	CommunicationBus.commands.setHandler "module:sample:start", (region) ->
		new SampleModule region: region