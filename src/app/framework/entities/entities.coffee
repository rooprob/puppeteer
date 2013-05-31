define [
	'jquery',
	'backbone',
	'underscore',
	'communication-bus'],
($, Backbone, _, Bus) ->

	_sync = Backbone.sync
	methods =
		beforeSend: -> @trigger "sync:start", @
		complete: -> @trigger "sync:stop", @

	Backbone.sync = (method, entity, options = {}) ->
		_.defaults options,
			beforeSend: _.bind methods.beforeSend, entity
			complete: _.bind methods.complete, entity

		sync = _sync method, entity, options

		if !entity._fetchPromise and method is "read"
			entity._fetchPromise = sync

	Bus.commands.setHandler "when:fetched", (entities, callback) ->
		xhrs = _.chain([entities]).flatten().pluck("_fetchPromise").value()
		$.when(xhrs...).done callback