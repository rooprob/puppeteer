define [
	'modules/header/views/header-view'
	'app.framework'
	'communication-bus'
], (HeaderView, Framework, CommunicationBus) ->

	# Define ShowController class
	class ShowController extends Framework.Controller

		# This initialize method will execute on instantiation of this class
		initialize: ->
			# Show a HeaderView instance on Controller's region.
			# "show()" is a method available on all Controllers, it takes
			# given View instance and shows it on Controller's region
			@show new HeaderView

	# Return ShowController object (because this is a RequireJS module)
	return ShowController