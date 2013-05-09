define ['marionette'], (Marionette) ->

	class View extends Marionette.View

	_remove = Marionette.View::remove
	_initialize = Marionette.View::initialize

	_.extend Marionette.View::,
		initialize: (args...) ->
			@.on 'before:render', ->
				@$el.hide() if @animations?.render is "fadeIn"

			@.on 'render', ->
				@$el.fadeIn() if @animations?.render is "fadeIn"

			@.on 'before:close', ->
				@$el.fadeOut() if @animations?.close is "fadeOut"

			_initialize.apply @, args

		# Overwrite default Marionette's Views "remove" method
		# to allow logging out when views are removed
		remove : (args...) ->
				console.log "Removing view:", @
				_remove.apply @, args

	return View