define [
	'modules/sample/views/first-view'
	'app.framework'
	'communication-bus'
], (FirstView, Framework, CommunicationBus) ->

	# Define FirstController class
	class FirstController extends Framework.Controller

		# This initialize method will execute on instantiation of this class
		initialize: ->
			# Get a FirstView instance
			firstView = new FirstView

			# Listen to the view "click-me:clicked". View will fire this event at some
			# point after user interaction (clicking a button, submitting a form…)
			@listenTo firstView, "button-go-to-second:clicked", =>
				# When "button-go-to-second:clicked" view event is triggered, launch
				# a global "app:navigate" command. This command is listened by
				# the app, and it provokes a history navigation to the given route
				# with the given options.
				# This event provokes a Backbone's own "navigate()" call, so for
				# options you can see: http://backbonejs.org/#Router-navigate
				CommunicationBus.commands.execute "app:navigate", 'sample/second', trigger: true

			# Show view on Controller's region.
			# "show()" is a method available on all Controllers, it takes
			# given View instance and shows it on Controller's region
			@show firstView

	# Return FirstController object (because this is a RequireJS module)
	return FirstController