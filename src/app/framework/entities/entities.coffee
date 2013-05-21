define [
	'jquery',
	'backbone',
	'underscore',
	'communication-bus'],
($, Backbone, _, CommunicationBus) ->

	do (Backbone) ->
		_sync = Backbone.sync

		Backbone.sync = (method, entity, options = {}) ->
			_.defaults options,
				beforeSend: _.bind methods.beforeSend, entity
				complete: _.bind methods.complete, entity

			sync = _sync method, entity, options
			entity._fetchPromise = sync if !entity._fetchPromise and method is "read"

		methods =
			beforeSend: -> @trigger "sync:start", @
			complete: -> @trigger "sync:stop", @

	CommunicationBus.commands.setHandler "when:fetched", (entities, callback) ->
		xhrs = _.chain([entities]).flatten().pluck("_fetchPromise").value()
		$.when(xhrs...).done callback