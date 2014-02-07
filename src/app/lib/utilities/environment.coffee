@App.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

	App.on "initialize:before", (options) ->
		App.environment = options.environment
