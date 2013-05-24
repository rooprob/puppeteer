define [
	'modules/sample/views/third-view'
	'app.framework'
	'communication-bus'
], (ThirdView, Framework, Bus) ->

	class ThirdController extends Framework.Controller

		initialize: ->
			thirdView = new ThirdView

			@listenTo thirdView, "button-go-to-second:clicked", ->
				Bus.commands.execute "module:sample:second:start"

			@show thirdView

	return ThirdController