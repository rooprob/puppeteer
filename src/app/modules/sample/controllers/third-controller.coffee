define [
	'modules/sample/views/third-view'
	'app.framework'
	'communication-bus'
], (ThirdView, Framework, CommunicationBus) ->

	class ThirdController extends Framework.Controller

		initialize: ->
			thirdView = new ThirdView

			@listenTo thirdView, "button-go-to-second:clicked", ->
				CommunicationBus.commands.execute "module:sample:second-controller:start"

			@show thirdView

	return ThirdController