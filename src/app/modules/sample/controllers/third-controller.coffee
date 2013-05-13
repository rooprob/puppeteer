define [
	'modules/sample/views/third-view'
	'app.framework'
	'communication-bus'
], (ThirdView, Framework, CommunicationBus) ->

	# Define ThirdController class
	class ThirdController extends Framework.Controller

		# This initialize method will execute on instantiation of this class
		initialize: ->
			# Get a getThirdView instance
			thirdView = new ThirdView

			# Listen to the view "button-go-to-second:clicked". View
			# will fire this event at some point after user
			# interaction (clicking a button, submitting a form…)
			@listenTo thirdView, "button-go-to-second:clicked", ->
				# We can't use a navigation command to show again the SecondController
				# because the URL didn't change when showing ThirdController (it's not
				# routed). That's why we need to do it in other way.
				# Since it is not ThirdController responsability to start
				# the SecondController, we delegate this action to the module
				# We'll do this with a global command, listened from the module
				CommunicationBus.commands.execute "module:sample:second-controller:start"

			@show thirdView

	# Return ThirdController object (because this is a RequireJS module)
	return ThirdController