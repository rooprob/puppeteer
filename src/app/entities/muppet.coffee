@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.Muppet extends Entities.Model

	class Entities.Muppets extends Entities.Collection
		model: Entities.Muppet

	array = []
	array.push { id: 1, name: "Kermit the Frog" }
	array.push { id: 2, name: "Ms. Piggy" }
	array.push { id: 3, name: "The Great Gonzo" }
	array.push { id: 4, name: "Swedish Chef" }

	API =
		getMuppet: (id) ->
			data = _.find array, (item) ->
				return item.id == id

			return new Entities.Muppet data

		getMuppets: ->
			return new Entities.Samples array

	App.reqres.setHandler "muppet:entity", (id) ->
		API.getMuppet id if id

	App.reqres.setHandler "muppet:entities", ->
		API.getMuppets()
