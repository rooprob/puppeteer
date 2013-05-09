define [
	'modules/header/views/header-view'
	'app.framework'
	'communication-bus'
], (HeaderView, Framework, CommunicationBus) ->

	class ShowController extends Framework.Controller

		initialize: ->
			@show new HeaderView

	return ShowController