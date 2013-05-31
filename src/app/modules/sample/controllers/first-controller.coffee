define [
	'modules/sample/views/first-view'
	'app.framework'
	'communication-bus'
], (FirstView, Framework, Bus) ->

	class FirstController extends Framework.Controller

		initialize: (module) ->
			firstView = new FirstView

			@listenTo firstView, "button-go-to-second:clicked", ->
				Bus.commands.execute "app:navigate", 'sample/second', trigger: true

			@show firstView

	return FirstController