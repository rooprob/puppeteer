define [
	'modules/sample/views/first-view'
	'app.framework'
	'communication-bus'
	'backbone'
], (FirstView, Framework, CommunicationBus, Backbone) ->

	class FirstController extends Framework.Controller

		initialize: ->
			firstView = @getFirstView()

			@listenTo firstView, "click-me:clicked", =>
				CommunicationBus.vent.trigger "app:navigate", 'sample/second', trigger: true

			@show firstView

		getFirstView: ->
			new FirstView

	return FirstController