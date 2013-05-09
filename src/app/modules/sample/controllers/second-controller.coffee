define [
	'modules/sample/init'
	'modules/sample/views/second-view'
	'app.framework'
	'communication-bus'
], (SampleModule, SecondView, Framework, CommunicationBus) ->

	# Define SecondController class
	class SecondController extends Framework.Controller

		# This initialize method will execute on instantiation of this class
		initialize: ->
			# Get a SecondView instance
			secondView = @getSecondView()

			# Listen to the view "click-me:clicked". View will fire this event at some
			# point after user interaction (clicking a button, submitting a form…)
			@listenTo secondView, "click-me:clicked", ->
				# When "click-me:clicked" view event is triggered, launch
				# a global "app:navigate" event. This event is listened by
				# the app, and it provokes a history navigation to the given route
				# with the given options.
				# This event provokes a Backbone's own "navigate()" call, so for
				# options you can see: http://backbonejs.org/#Router-navigate
				CommunicationBus.vent.trigger "app:navigate", '', trigger: true

			# Show view on Controller's region.
			# "show()" is a method available on all Controllers, it takes
			# given View instance and shows it on Controller's region
			@show secondView

		# Method that returns a new instance of SecondView
		getSecondView: ->
			new SecondView

	# Return SecondController object (because this is a RequireJS module)
	return SecondController