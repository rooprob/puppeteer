define [
	'marionette',
	'underscore',
	'communication-bus'
], (Marionette, _, CommunicationBus) ->

	class Controller extends Marionette.Controller

		constructor: (options = {}) ->
			@region = options.region or CommunicationBus.reqres.request "app:default:region"
			super options
			@_instance_id = _.uniqueId("controller")
			CommunicationBus.commands.execute "register:instance", @, @_instance_id

		close: (args...) ->
			super args
			CommunicationBus.commands.execute "unregister:instance", @_instance_id

		show: (view) ->
			@listenTo view, "close", @close

			@region.show view

	return Controller