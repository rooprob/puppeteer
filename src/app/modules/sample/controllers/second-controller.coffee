define [
	'modules/sample/views/second-view'
	'app.framework'
	'communication-bus'
], (SecondView, Framework, CommunicationBus) ->

	class SecondController extends Framework.Controller

		initialize: ->
			secondView = new SecondView

			@listenTo secondView, "button-go-to-first:clicked", ->
				CommunicationBus.commands.execute "app:navigate", '', trigger: true

			@listenTo secondView, "button-go-to-second:clicked", =>
				CommunicationBus.commands.execute "module:sample:third-controller:start"

			@show secondView

	return SecondController