@App.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->

	class Controllers.Application extends Marionette.Controller

		constructor: (options = {}) ->
			@region = options.region or App.request "default:region"
			super options
			@_instance_id = _.uniqueId("controller")
			App.execute "register:instance", @, @_instance_id

		close: ->
			console.log "closing", @ if App.environment is "dev"

			App.execute "unregister:instance", @, @_instance_id
			super

		show: (view, options = {}) ->
			_.defaults options,
				region: @region

			# A controller could display another controller that could display a view.
			while view.getMainView then view = view.getMainView()

			if not view
				throw new Error("getMainView() did not return a view instance or #{view?.constructor?.name} is not a view instance")

			@setMainView view
			@_manageView view, options

		getMainView: ->
			@_mainView

		setMainView: (view) ->
			return if @_mainView

			@_mainView = view
			@listenTo view, "close", @close

		_manageView: (view, options) ->
			options.region.show view
