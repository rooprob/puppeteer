@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Application

		# -------------------------------------------------------
		# INIT
		# -------------------------------------------------------
		initialize: ->
			@layout = @getLayoutView()
			@muppets = App.request "muppet:filterable:entities"

			@listenTo @layout, "show", =>
				@handleFilterRegion()
				@handleContentRegion()

			@show @layout

		# -------------------------------------------------------
		# LAYOUT REGIONS
		# -------------------------------------------------------
		handleFilterRegion: ->
			filterComponent = App.request "filter:component"

			@listenTo filterComponent, "filter:text:changed", (text) ->
				@muppets.filterByName text.trim()

			@layout.filter.show filterComponent.getMainView()

		handleContentRegion: ->
			listView = @getListView @muppets

			@listenTo listView, "itemview:muppet:clicked", (itemView, opts) ->
				App.vent.trigger "muppet:selected", opts.model

			@layout.content.show listView

		# -------------------------------------------------------
		# VIEWS
		# -------------------------------------------------------
		getListView: ->
			new List.ListView
				collection: @muppets

		getLayoutView: ->
			new List.Layout()
