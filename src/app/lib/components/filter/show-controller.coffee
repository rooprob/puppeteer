@App.module "Components.Filter", (Filter, App, Backbone, Marionette, $, _) ->


	# ----------------------------------------------
	# Class definition
	# ----------------------------------------------
	class Filter.Controller extends App.Controllers.Application
		initialize: (options) ->
			@options = options

			view = @getFilterView(options)
			@setMainView view

			# whenever filter text changes, any listener of this component
			# will become aware
			@listenTo view, "filter:text:changed", (text) =>
				if (text != options.filter)
					@trigger "filter:text:changed", text

				options.filter = text

			# when it first show, update its listener with its own state
			@listenTo view, "show", ()->
				@trigger "filter:text:changed", options.filter || ""
		
		getFilterView: (options)->
			new Filter.FilterView(options)

	# ----------------------------------------------
	# App requests
	# ----------------------------------------------
	App.reqres.setHandler "filter:component", (options) ->
		new Filter.Controller options

