define [
	'modules/sample/views/second-view'
	'app.framework'
	'communication-bus'
], (SecondView, Framework, Bus) ->

	class SecondController extends Framework.Controller

		initialize: ->
			secondView = new SecondView

			@listenTo secondView, "button-go-to-first:clicked", ->
				Bus.commands.execute "app:navigate", '', trigger: true

			@listenTo secondView, "button-go-to-second:clicked", =>
				Bus.commands.execute "module:sample:third:start"

			@show secondView

	return SecondController