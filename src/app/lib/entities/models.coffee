@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.Model extends Backbone.Model

		destroy: (options = {}) ->
			_.defaults options,
				wait: true

			@set _destroy: true
			super options

		isDestroyed: ->
			@get "_destroy"

		save: (data, options = {}) ->
			isNew = @isNew()

			_.defaults options,
				wait: true
				success: _.bind(@saveSuccess, @, isNew, options.collection, options.callback)
				error: _.bind(@saveError, @)

			@unset "_errors"
			super data, options

		saveSuccess: (isNew, collection, callback) =>
			if isNew
				collection?.add @
				collection?.trigger "model:created", @
				@trigger "created", @
			else
				collection ?= @collection
				collection?.trigger "model:updated", @
				@trigger "updated", @

			callback?()

		saveError: (model, xhr, options) =>
			@set _errors: $.parseJSON(xhr.responseText)?.errors unless /500|404/.test xhr.status

	API =
		newModel: (attrs) ->
			new Entities.Model attrs

	App.reqres.setHandler "new:model", (attrs = {}) ->
		API.newModel attrs
