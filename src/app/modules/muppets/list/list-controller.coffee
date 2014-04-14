# # List Controller
#
# This controller will handle everything related to the "list" action
# of the `Muppet` module.
#
# Extends from `App.Controllers.Application`, which in the end is nothing
# but a custom extension of `Marionette.Controller`.
@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Application

		# ##Initialize
		#
		# Shows a `List.LayoutView` containing the list of `Muppet` models
		# and a filtering text box.
		initialize: ->

			# Instantiates the `LayoutView`
			@layout = @getLayoutView()

			# Get the `Muppets` collection
			@muppets = App.request "muppet:entities"

			# Get the `Muppets` to be shown on the list
			@visibleMuppets = @getVisibleMuppets @muppets

			# When the layout is shown, the `FilterRegion`
			# and the `ContentRegion` are set up
			@listenTo @layout, "show", =>
				@handleFilterRegion()
				@handleContentRegion()

			# Shows the `LayoutView`
			@show @layout

		# ## applyFilter
		#
		# Filters the `Muppets` list with those who matches
		# the given text.
		applyFilter: (text) =>
			@visibleMuppets.reset @muppets.filterByName(text.trim())

		# ## getVisibleMuppets
		#
		# Returns a clone of the `Muppets` list, to be used as a
		# filterable list show on the interface.
		getVisibleMuppets: ->
			@visibleMuppets or= new @muppets.constructor(@muppets.models)

		# ##handleFilterRegion
		#
		# Shows the filter component on the `filterRegion` of the `LayoutView`,
		# handling all the events produced by the component.
		handleFilterRegion: ->

			# Request the component
			filterComponent = App.request "filter:component"

			# Set the controller to listen to the `filter:text:changed` event
			# from the component. When it occurs, performs the filtering of the
			# `Muppets` list
			@listenTo filterComponent, "filter:text:changed", @applyFilter

			# Shows the component on the `filterRegion` of the `LayoutView`
			@show filterComponent, region: @layout.filterRegion

		# ## handleContentRegion
		#
		# Shows a `ListView` on the `contentRegion` of the `LayoutView`,
		# handling all the events produced by the view.
		handleContentRegion: ->

			# Instances the `ListView`
			listView = @getListView()

			# Set the controller to listen to the `itemview:muppet:clicked` event
			# from the `ListView`. When it occurs, triggers a `muppet:selected` event
			# passing the clicked `Muppet`. That event is handled
			# on the [Muppet module](../muppet.html).
			@listenTo listView, "itemview:muppet:clicked", (itemView, opts) ->
				App.vent.trigger "muppet:selected", opts.model

			# Shows the `ListView` on the `contentRegion` of the `LayoutView`.
			@show listView, region: @layout.contentRegion

		# ## getListView
		#
		# Returns a new instance of a `ListView`, passing the list of filterable
		# `Muppets`
		getListView: ->
			new List.ListView
				collection: @visibleMuppets

		# ## getLayoutView
		#
		# Returns a new instance of a `LayoutView`
		getLayoutView: ->
			new List.Layout()

