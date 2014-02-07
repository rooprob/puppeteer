@App.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

	App.autoInitHistory ?= true

	_.extend App,
		navigate: (route, options = {}) ->
			Backbone.history.navigate route, options

		getCurrentRoute: ->
			frag = Backbone.history.fragment
			if _.isEmpty(frag) then null else frag

		startHistory: ->
			Backbone.history.start() if Backbone.history

	if App.autoInitHistory
		App.on "initialize:after", ->
			@startHistory()
			@navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

