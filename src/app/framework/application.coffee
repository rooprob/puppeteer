define [
	'backbone'
	'marionette'
	'underscore'
	'communication-bus'
], (Backbone, Marionette, _, Bus) ->

	class Application extends Marionette.Application
		constructor: (args...) ->
			super args

			@.on "initialize:after", (options) =>
				@history.startHistory()

				if @rootRoute
					@history.navigate(@rootRoute, trigger: true) unless @history.getCurrentRoute()

			@history.attachHandlers()

		setDefaultRegion: (region) ->
			Bus.reqres.setHandler "app:default:region", -> return region

		history:
			attachHandlers: ->
				Bus.commands.setHandler 'app:navigate', (route, options = {}) =>
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

	return Application