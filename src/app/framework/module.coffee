define [
	'underscore'
	'communication-bus'
], (_, CommunicationBus) ->

	class Module
		initialize: ->

		constructor: (options = {}) ->
			if @events and _.isObject @events
				_.each @events, (val, key) ->
					CommunicationBus.vent.on key, val

			if @requests and _.isObject @requests
				_.each @requests, (val, key) ->
					CommunicationBus.reqres.setHandler key, val

			if @commands and _.isObject @commands
				_.each @commands, (val, key) ->
					CommunicationBus.commands.setHandler key, val

			@initialize options

	return Module