define [
	'modules/header/views/header-view'
	'app.framework'
	'communication-bus'
], (HeaderView, Framework, CommunicationBus) ->

	# Define ShowController class
	class ShowController extends Framework.Controller

		# This initialize method will execute on instantiation of this class
		initialize: ->
			# Get a HeaderView instance
			headerView = new HeaderView

			# Show a HeaderView instance on Controller's region.
			# "show()" is a method available on all Controllers, it takes
			# given View instance and shows it on Controller's region
			@show headerView

			# Events for module selection. This events will be triggered
			# from inside our sample modules ('sample' and 'other'). Will
			# use this events to mark the active navigation item
			CommunicationBus.vent.on "module:sample:selected", =>
				@activateNavLink headerView.ui.sampleModuleLink

			CommunicationBus.vent.on "module:other:selected", =>
				@activateNavLink headerView.ui.otherModuleLink

		# Mark given nav link as active
		activateNavLink: (link) ->
			parent = link.parent()
			activeClass = 'active'
			parent.siblings().removeClass activeClass
			parent.addClass activeClass

	# Return ShowController object (because this is a RequireJS module)
	return ShowController