define [
	'backbone'
	'marionette'
	'underscore'
	'communication-bus'
], (Backbone, Marionette, _, CommunicationBus) ->

	class Module
		initialize: ->
		constructor: (options = {}) ->
			@initialize options

	return Module