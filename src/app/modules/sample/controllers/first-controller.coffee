define [
	'modules/sample/views/first-view'
	'app.framework'
	'communication-bus'
], (FirstView, Framework, CommunicationBus) ->

	class FirstController extends Framework.Controller

		initialize: ->
			firstView = new FirstView

			@listenTo firstView, "button-go-to-second:clicked", =>
				CommunicationBus.commands.execute "app:navigate", 'sample/second', trigger: true

			@show firstView

	return FirstController