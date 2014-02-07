@App.module "SampleModule.Trololo", (Trololo, App, Backbone, Marionette, $, _) ->

	class Trololo.Controller extends App.Controllers.Application

		initialize: ->
			trololoView = @getTrololoView()
			@show trololoView

		getTrololoView: ->
			new Trololo.TrololoView
