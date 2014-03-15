@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Controller extends App.Controllers.Application

		initialize: ->
			muppets = App.request "muppet:entities"
			listView = @getListView muppets

			@listenTo listView, "itemview:muppet:clicked", (itemView, opts) ->
				App.vent.trigger "muppet:selected", opts.model

			@show listView

		getListView: (collection) ->
			new List.ListView
				collection: collection
