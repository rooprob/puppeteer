@App.module "Components.Filter", (Filter, App, Backbone, Marionette, $, _) ->

	timer = null

	class Filter.FilterView extends App.Views.ItemView
		className: "filter-component"
		template: "filter/filter"
		ui:
			textfield: "input[type='text']"
		events:
			"keyup @ui.textfield": (e) ->
				e.preventDefault()

				clearTimeout timer

				timer = setTimeout =>
					@trigger "filter:text:changed", @ui.textfield.val()
				, @options.delay || 0

		serializeData: ->
			return @options
