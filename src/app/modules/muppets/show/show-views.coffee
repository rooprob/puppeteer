@App.module "MuppetsModule.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.MuppetView extends App.Views.ItemView
		className: "muppet-view"
		template: "muppets/show/muppet-view"
