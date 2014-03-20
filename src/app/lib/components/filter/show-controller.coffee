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

			view = API.getFilterView()

			@setMainView view

			@listenTo view, "filter:text:changed", (text) =>
				@trigger "filter:text:changed", text

	# ----------------------------------------------
	# App requests
	# ----------------------------------------------
	App.reqres.setHandler "filter:component", (options) ->
		new Filter.Controller options

