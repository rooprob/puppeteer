@App.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

	API =
		register: (instance, id) ->
			App._registry ?= {}
			App._registry[id] = instance

		unregister: (instance, id) ->
			delete App._registry[id]

		resetRegistry: ->
			oldCount = @getRegistrySize()

			@closeRegions()

			ret =
				count: @getRegistrySize()
				previous: oldCount
				msg: "There were #{oldCount} controllers in the registry, there are now #{@getRegistrySize()}"

			console.info ret.msg if App.environment is "dev"

			return ret

		closeRegions: ->
			for key, controller of App._registry
				controller?.region?.close()

		getRegistrySize: ->
			_.size(App._registry)

	App.commands.setHandler "register:instance", (instance, id) ->
		API.register instance, id if App.environment is "dev"

	App.commands.setHandler "unregister:instance", (instance, id) ->
		API.unregister instance, id if App.environment is "dev"

	App.reqres.setHandler "reset:registry", ->
		API.resetRegistry()
