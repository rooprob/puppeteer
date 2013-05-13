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
				@history.startHistory()

				if @rootRoute
					@history.navigate(@rootRoute, trigger: true) unless @history.getCurrentRoute()

			@history.attachHandlers()
			@registry.attachHandlers()

		setDefaultRegion: (region) ->
			CommunicationBus.reqres.setHandler "app:default:region", ->
				region

		history:
			attachHandlers: ->
				CommunicationBus.commands.setHandler 'app:navigate', (route, options = {}) =>
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

		registry:
			attachHandlers: ->
				CommunicationBus.commands.setHandler "register:instance", (instance, id) =>
					@add instance, id

				CommunicationBus.commands.setHandler "unregister:instance", (id) =>
					@remove id

				CommunicationBus.commands.setHandler "reset:instances", =>
					@reset()

				CommunicationBus.commands.setHandler "list:instances", =>
					console.log @_registry

				window.CommunicationBus = CommunicationBus

			add: (instance, id) ->
				@_registry ?= {}
				@_registry[id] = instance

			remove: (id) ->
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