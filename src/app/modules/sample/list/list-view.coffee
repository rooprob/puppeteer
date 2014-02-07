@App.module "SampleModule.List", (List, App, Backbone, Marionette, $, _) ->

	class List.SampleView extends App.Views.ItemView
		template: "sample/list/sample-view"
