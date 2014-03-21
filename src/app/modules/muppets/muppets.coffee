@App.module "MuppetsModule", (MuppetsModule, App, Backbone, Marionette, $, _) ->

	class MuppetsModule.Router extends Marionette.AppRouter
		appRoutes:
			"muppets": "list"
			"muppets/:id": "show"

	API =
		list: ->
			new MuppetsModule.List.Controller()

		show: (muppet) ->
			if muppet.id?
				App.navigate "muppets/#{muppet.id}"
			else
				muppet = App.request "muppet:entity", muppet

			new MuppetsModule.Show.Controller muppet

	App.vent.on "muppet:selected", (muppet) ->
		API.show muppet

	App.addInitializer ->
		new MuppetsModule.Router
			controller: API