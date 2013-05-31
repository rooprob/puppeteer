define [
	'marionette'
	'underscore'
], (Marionette, _) ->

	# Store original method prototype references
	_remove = Marionette.View::remove
	_initialize = Marionette.View::initialize

	# Hide view if "render" view animation is one that needs
	# the view to be hidden at the beggining. We don't need this
	# method to be part of View instances, that's why it is not
	# attached to it
	hideIfRenderAnimation = (view) ->
		animation = view.getAnimationFor 'render'

		if animation in ['fadeIn', 'slideDown', 'show']
			view.$el.hide()

	# Extends Marionette.View prototype
	_.extend Marionette.View::,

		# Sets up listeners for "render" and "before:close" view
		# events, which will be used to launch view animations if needed
		initialize: (args...) ->
			@on 'before:render', => hideIfRenderAnimation @
			@on 'render', => @performAnimation 'render'
			@on 'before:close', => @performAnimation 'close'

			_initialize.apply @, args

		# Returns the defined animation for the given action, if any
		getAnimationFor : (action) ->
			return @animations[action] if @animations?[action]

		# Perform view animation for given action, if it exists.
		# Available animations are defined on "animations" view attribute
		# as an object with an "action" key, and an "animation"
		# value. Right now, "actions" are just "render" and "close",
		# and "animations" can be any of the jQuery catalog ("fadeIn",
		# "slideDown"…)
		performAnimation : (action) ->
			animation = @getAnimationFor action

			if animation
				_.defer => @$el.hide()[animation]()

		# Overwrite default Marionette's Views "remove" method
		# to allow logging out views when they are removed
		remove : (args...) ->
			console.log "Removing view:", @
			_remove.apply @, args