define [
	'marionette',
	'communication-bus'
], (Marionette, Bus) ->

	class Controller extends Marionette.Controller

		constructor: (options = {}) ->
			@region = options.region or Bus.reqres.request "app:default:region"
			console.warn "Controller needs a region", @region if not @region

			super options

		show: (view) ->
			@listenTo view, "close", @close
			@region.show view

	return Controller