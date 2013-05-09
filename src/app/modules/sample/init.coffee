define [
	'modules/sample/controllers/first-controller'
	'modules/sample/controllers/second-controller'
	'app.framework'
	'communication-bus'
], (FirstController, SecondController, Framework, CommunicationBus) ->

	# Define SampleModule class
	class SampleModule extends Framework.Module

		# This initialize method will execute on instantiation of this class
		initialize: (options = {}) =>

			# Instantiate a new Framework.AppRouter, linking it with "router"
			# property of the Module.
			# The router will manage association between URLs and methods.
			@router = new Framework.AppRouter
				routes:
					# When navigating to "", instantiate a FirstController
					""							: => new FirstController

					# When navigating to "sample/second", instantiate a SecondController
					"sample/second"	: => new SecondController

	# Return SampleModule object (because this is a RequireJS module)
	return SampleModule