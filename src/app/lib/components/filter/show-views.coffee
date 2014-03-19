@App.module "Components.Filter", (Filter, App, Backbone, Marionette, $, _) ->

	class Filter.FilterView extends App.Views.ItemView
		template: "filter/filter"
		ui:
			textfield: "input[type='text']"
		events:
			"keyup @ui.textfield": (e) ->
				e.preventDefault()
				@trigger "filter:text:changed", @ui.textfield.val()
