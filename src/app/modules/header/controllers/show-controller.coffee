define [
	'modules/header/views/header-view'
	'app.framework'
	'communication-bus'
], (HeaderView, Framework, CommunicationBus) ->

	class ShowController extends Framework.Controller

		initialize: ->
			headerView = new HeaderView
			@show headerView

			CommunicationBus.vent.on "module:sample:selected", =>
				@activateNavLink headerView.ui.sampleModuleLink

			CommunicationBus.vent.on "module:other:selected", =>
				@activateNavLink headerView.ui.otherModuleLink

		activateNavLink: (link) ->
			parent = link.parent()
			activeClass = 'active'
			parent.siblings().removeClass activeClass
			parent.addClass activeClass

	return ShowController