@App.module "MuppetsModule.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Application
		initialize: (muppet) ->
			muppetView = @getMuppetView muppet
			@show muppetView

		getMuppetView: (muppet) ->
			new Show.MuppetView
				model: muppet
