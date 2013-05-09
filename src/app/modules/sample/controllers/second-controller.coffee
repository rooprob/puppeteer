define [
	'modules/sample/init'
	'modules/sample/views/second-view'
	'app.framework'
	'communication-bus'
], (SampleModule, SecondView, Framework, CommunicationBus) ->

	class SecondController extends Framework.Controller

		initialize: ->
			secondView = @getSecondView()

			@listenTo secondView, "click-me:clicked", ->
				CommunicationBus.vent.trigger "app:navigate", '', trigger: true

			@show secondView

		getSecondView: ->
			new SecondView

	return SecondController