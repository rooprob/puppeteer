@App.module "Components.Filter", (Filter, App, Backbone, Marionette, $, _) ->

	# ----------------------------------------------
	# API
	# ----------------------------------------------
	API =
		getFilterView: ->
			new Filter.FilterView()

	# ----------------------------------------------
	# Class definition
	# ----------------------------------------------
	class Filter.Controller extends App.Controllers.Application
		initialize: (options) ->
			@options = options
			return if not @options.collection or not _.isFunction(@options.filter)

			@collection = @options.collection
			@originalModels = @collection.models
			view = API.getFilterView()

			@setMainView view

			@listenTo view, "filter:text:changed", (text) ->
				text = text.trim()
				models = _.clone @originalModels

				if text isnt ""
					models = @filter models, text

				@collection.reset models

		filter: (models, text) ->
			filteredModels = _.filter models, (model) =>
				return @options.filter(model, text)

			return filteredModels

	# ----------------------------------------------
	# App requests
	# ----------------------------------------------
	App.reqres.setHandler "filter:component", (options) ->
		new Filter.Controller options

