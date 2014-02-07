@App.module "Views", (Views, App, Backbone, Marionette, $, _) ->

	_remove = Marionette.View::remove

	_.extend Marionette.View::,

		remove: (args...) ->
			console.log "removing", @ if App.environment is "dev"
			_remove.apply @, args
