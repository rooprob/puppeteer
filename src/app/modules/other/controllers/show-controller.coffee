define [
	'modules/other/views/show-view'
	'app.framework'
	'communication-bus'
], (ShowView, Framework, CommunicationBus) ->

	class ShowController extends Framework.Controller

		initialize: ->
			@show new ShowView

	return ShowController