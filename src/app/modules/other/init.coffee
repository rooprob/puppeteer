define [
	'modules/other/controllers/show-controller'
	'app.framework'
	'communication-bus'
], (ShowController, Framework, CommunicationBus) ->

	# Define OtherModule class
	class OtherModule extends Framework.Module

		# This initialize method will execute on instantiation of this class
		initialize: (options = {}) ->
			# Instantiate a new Framework.AppRouter.
			# The router will manage association between URLs and actions.
			new Framework.AppRouter
				routes:
					"other": => @startController "show-controller"

		# Attach command handlers
		commands:
			"module:other:show-controller:start": -> new ShowController

		# Start given controller, triggering a "module selected" event
		# which, for this sample, will be used on HeaderModule to mark
		# active navigation link
		startController: (controller) ->
			CommunicationBus.commands.execute "module:other:#{controller}:start"
			CommunicationBus.vent.trigger "module:other:selected"

	# Register Module's start command
	CommunicationBus.commands.setHandler "module:other:start", (region) ->
		new OtherModule region: region