define [
	'modules/other/controllers/show-controller'
	'app.framework'
	'communication-bus'
], (ShowController, Framework, Bus) ->

	class OtherModule extends Framework.Module

		initialize: ->
			@setCommands
				"module:other:show:start": -> new ShowController

			@setRoutes
				"other": => @startController "show"

		startController: (controller) ->
			Bus.commands.execute "module:other:#{controller}:start"
			Bus.vent.trigger "module:other:selected"

	return OtherModule