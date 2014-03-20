@App.module "Components.Filter", (Filter, App, Backbone, Marionette, $, _) ->


	# ----------------------------------------------
	# Class definition
	# ----------------------------------------------
	class Filter.Controller extends App.Controllers.Application
		initialize: (options) ->
			@options = options

			view = @getFilterView()
			@setMainView view

			@listenTo view, "filter:text:changed", (text) =>
				@trigger "filter:text:changed", text
		
		getFilterView: ->
			new Filter.FilterView()

	# ----------------------------------------------
	# App requests
	# ----------------------------------------------
	App.reqres.setHandler "filter:component", (options) ->
		new Filter.Controller options

