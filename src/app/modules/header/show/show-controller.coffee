@App.module "HeaderModule.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.Controller extends App.Controllers.Application

		initialize: ->
			headerView = @getHeaderView()
			@show headerView

		getHeaderView: ->
			new Show.HeaderView()
