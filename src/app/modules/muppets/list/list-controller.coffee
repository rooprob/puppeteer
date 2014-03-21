@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Application

		# -------------------------------------------------------
		# INIT
		# -------------------------------------------------------
		initialize: ->
			@layout = @getLayoutView()
			@muppets = App.request "muppet:entities"
			@visibleMuppets = @getVisibleMuppets @muppets

			@listenTo @layout, "show", =>
				@handleFilterRegion()
				@handleContentRegion()

			@show @layout

		# -------------------------------------------------------
		# API
		# -------------------------------------------------------
		applyFilter: (text) =>
			@visibleMuppets.reset @muppets.filterByName(text.trim())

		getVisibleMuppets: ->
			@visibleMuppets or= new @muppets.constructor(@muppets.models)

		# -------------------------------------------------------
		# LAYOUT REGIONS
		# -------------------------------------------------------
		handleFilterRegion: ->
			filterComponent = App.request "filter:component"

			@listenTo filterComponent, "filter:text:changed", @applyFilter

			@show filterComponent, region: @layout.filterRegion

		handleContentRegion: ->
			listView = @getListView()

			@listenTo listView, "itemview:muppet:clicked", (itemView, opts) ->
				App.vent.trigger "muppet:selected", opts.model

			@show listView, region: @layout.contentRegion

		# -------------------------------------------------------
		# VIEWS
		# -------------------------------------------------------
		getListView: ->
			new List.ListView
				collection: @visibleMuppets

		getLayoutView: ->
			new List.Layout()

