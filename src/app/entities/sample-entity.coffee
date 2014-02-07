@App.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.Sample extends Entities.Model

	class Entities.Samples extends Entities.Collection
		model: Entities.Sample

	API =
		getSamples: ->
			array = []
			array.push { name: "Sample 1" }
			array.push { name: "Sample 2" }
			array.push { name: "Sample 3" }

			samples = new Entities.Samples array
			return samples

	App.reqres.setHandler "sample:entities", ->
		API.getSamples()
