@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Layout extends App.Views.Layout
		template: "muppets/list/layout"
		regions:
			filterRegion: "#filter"
			contentRegion: "#content"

	class List.ItemView extends App.Views.ItemView
		className: "muppets-item"
		template: "muppets/list/muppet-item"
		tagName: "li"
		triggers:
			"click": "muppet:clicked"

	class List.ListView extends App.Views.CompositeView
		className: "muppets-list"
		template: "muppets/list/muppets-list"
		itemView: List.ItemView
		itemViewContainer: "ul"
