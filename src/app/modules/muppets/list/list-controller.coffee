@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Application

		# -------------------------------------------------------
		# INIT
		# -------------------------------------------------------
		initialize: ->
			@layout = @getLayoutView()
			@muppets = App.request "muppet:entities"

			@listenTo @layout, "show", =>
				@handleFilterRegion()
				@handleContentRegion()

			@show @layout

		# -------------------------------------------------------
		# LAYOUT REGIONS
		# -------------------------------------------------------
		handleFilterRegion: ->
			filterComponent = App.request "filter:component",
				collection: @muppets
				filter: (muppet, searchText) ->
					muppetName = muppet.get("name").toUpperCase()
					return _.include muppetName, searchText.toUpperCase()

			@layout.filter.show filterComponent.getMainView() if filterComponent.getMainView()

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
