@App.module "HeaderModule.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.HeaderView extends App.Views.ItemView
		template: "header/show/header"
