define [
	'marionette',
	'underscore',
	'communication-bus'
], (Marionette, _, CommunicationBus) ->

	class Controller extends Marionette.Controller

		constructor: (options = {}) ->
			@region = options.region or CommunicationBus.reqres.request "app:default:region"
			super options

		show: (view) ->
			@listenTo view, "close", @close
			@region.show view

	return Controller