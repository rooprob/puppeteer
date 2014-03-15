@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.ItemView extends App.Views.ItemView
		template: "muppets/list/muppet-item"
		tagName: "li"
		triggers:
			"click": "muppet:clicked"

	class List.ListView extends App.Views.CompositeView
		template: "muppets/list/muppets-list"
		itemView: List.ItemView
		itemViewContainer: "ul"
