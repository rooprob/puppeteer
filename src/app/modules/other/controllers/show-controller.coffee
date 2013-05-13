define [
	'modules/other/views/show-view'
	'app.framework'
	'communication-bus'
], (ShowView, Framework, CommunicationBus) ->

	# Define ShowController class
	class ShowController extends Framework.Controller

		# This initialize method will execute on instantiation of this class
		initialize: ->
			# Get a ShowView instance
			showView = new ShowView

			# Show view on Controller's region.
			# "show()" is a method available on all Controllers, it takes
			# given View instance and shows it on Controller's region
			@show showView

	# Return ShowController object (because this is a RequireJS module)
	return ShowController