define [
	'modules/other/views/show-view'
	'app.framework'
	'communication-bus'
], (ShowView, Framework, Bus) ->

	class ShowController extends Framework.Controller

		initialize: ->
			@show new ShowView

	return ShowController