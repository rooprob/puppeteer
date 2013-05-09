define [
	'backbone'
	'marionette'
	'underscore'
	'communication-bus'
], (Backbone, Marionette, _, CommunicationBus) ->

	class Application extends Marionette.Application
		constructor: (args...) ->
			super args

			@.on "initialize:after", (options) =>
				@startHistory()
				@navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

			CommunicationBus.commands.setHandler "register:instance", (instance, id) =>
				@registry.add instance, id

			CommunicationBus.commands.setHandler "unregister:instance", (instance, id) =>
				@registry.remove instance, id

			CommunicationBus.commands.setHandler "reset:instances", (instance, id) =>
				@registry.reset()

			CommunicationBus.vent.on 'app:navigate', (route, options = {}) =>
				@navigate(route, options)

		navigate: (route, options = {}) ->
			route = "#" + route if route and route.charAt(0) is "/"
			Backbone.history.navigate(route, options)

		getCurrentRoute: ->
			frag = Backbone.history.fragment
			if _.isEmpty(frag) then null else frag

		setRootRoute: (route) ->
			@rootRoute = route

		startHistory: ->
			Backbone.history.start() if Backbone.history

		setDefaultRegion: (region) ->
			CommunicationBus.reqres.setHandler "app:default:region", ->
				region

		registry:
			add: (instance, id) ->
				@_registry ?= {}
				@_registry[id] = instance

			remove: (instance, id) ->
				delete @_registry[id]

			reset: ->
				oldCount = @getSize()

				for key, controller of @_registry
					controller.region?.close()

				msg = "There were #{oldCount} controllers, there are now #{@getSize()}"

				if @getSize() > 0
					console.warn msg, @_registry
				else
					console.log msg

			getSize: ->
				_.size @_registry

	return Application