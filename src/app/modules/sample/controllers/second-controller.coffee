define [
	'modules/sample/views/second-view'
	'app.framework'
	'communication-bus'
], (SecondView, Framework, CommunicationBus) ->

	# Define SecondController class
	class SecondController extends Framework.Controller

		# This initialize method will execute on instantiation of this class
		initialize: ->
			# Get a SecondView instance
			secondView = new SecondView

			# Listen to the view "click-me:clicked". View will fire this event at some
			# point after user interaction (clicking a button, submitting a form…)
			@listenTo secondView, "button-go-to-first:clicked", ->
				# When "button-go-to-first:clicked" view event is triggered, launch
				# a global "app:navigate" command. This command is listened by
				# the app, and it provokes a history navigation to the given route
				# with the given options.
				# This event provokes a Backbone's own "navigate()" call, so for
				# options you can see: http://backbonejs.org/#Router-navigate
				CommunicationBus.commands.execute "app:navigate", '', trigger: true

			# Listen to the view "button-go-to-second:clicked".
			# View will fire this event at some point after user
			# interaction (clicking a button, submitting a form…)
			@listenTo secondView, "button-go-to-second:clicked", =>
				# ThirdController is not routed, so we can't use a navigation
				# command to start it.
				# Since it is not SecondController responsability to start
				# the ThirdController, we delegate this action to the module.
				# We'll do this with a global command, listened from the module.
				CommunicationBus.commands.execute "module:sample:third-controller:start"

			@show secondView

	# Return SecondController object (because this is a RequireJS module)
	return SecondController