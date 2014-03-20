@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Application

		# -------------------------------------------------------
		# INIT
		# -------------------------------------------------------
		initialize: ->
			@layout = @getLayoutView()
			@muppets = App.request "muppet:entities"
			@buffer = new @muppets.constructor(@muppets.models)

			@listenTo @layout, "show", =>
				@handleFilterRegion()
				@handleContentRegion()

			@show @layout

		# -------------------------------------------------------
		# LAYOUT REGIONS
		# -------------------------------------------------------
		handleFilterRegion: ->
			filterComponent = App.request "filter:component"

			@listenTo filterComponent, "filter:text:changed", (text)=>
				@buffer.reset @muppets.filterByName text.trim()

			@show filterComponent, region: @layout.filterRegion

		handleContentRegion: ->
			listView = @getListView @buffer

			@listenTo listView, "itemview:muppet:clicked", (itemView, opts) ->
				App.vent.trigger "muppet:selected", opts.model

			@show listView, region: @layout.contentRegion

		# -------------------------------------------------------
		# VIEWS
		# -------------------------------------------------------
		getListView: ->
			new List.ListView
				collection: @muppets

		getLayoutView: ->
			new List.Layout()
