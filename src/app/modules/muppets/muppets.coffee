# # Muppets Module
#
# This is the main file for the `Muppets` module. This is a routed module, so it
# needs a `Marionette.AppRouter` to be defined, setting the routes which it will
# listen.
@App.module "MuppetsModule", (MuppetsModule, App, Backbone, Marionette, $, _) ->

	# ## Router
	#
	# Defines a `Router` class which sets the URL paths to be watched
	# and the actions to be executed on each path:
	#
	# * `muppets`: Executes `list()` method
	# * `muppets/:id`: Executes `show()` method passing given `:id`
	class MuppetsModule.Router extends Marionette.AppRouter
		appRoutes:
			"muppets": "list"
			"muppets/:id": "show"

	# ## API
	#
	# Object which holds the methods to be executed by the module (through
	# the Router, or directly).
	API =

		# ### List
		#
		# Instantiates a new `List.Controller`.
		list: ->
			new MuppetsModule.List.Controller()

		# ### Show
		#
		# Instantiates a new `Show.Controller`, passing a `Muppet` model. This model
		# will be received directly as a parameter, or if the parameter is an
		# integer, the model must be requested previous to the instantiation of the
		# `Show.Controller`.
		show: (muppet) ->

			# If `muppet` parameter has an `id`, it means that is a `Muppet` model,
			# so the URL is updated to reflect the action that is being performed.
			if muppet.id?
				App.navigate "muppets/#{muppet.id}"

			# Else, `muppet` parameter should be an integer matching an `id` of an
			# existing `Muppet` model, so it is requested before showing it.
			else
				muppet = App.request "muppet:entity", muppet

			# Instantiate the `Show.Controller` passing the `Muppet` model to be
			# shown.
			new MuppetsModule.Show.Controller muppet

	# ## "muppet:selected" event
	#
	# Shows given `Muppet` model, which can be passed directly as an object, or
	# as an `id`.
	App.vent.on "muppet:selected", (muppet) ->
		API.show muppet

	# ## App initializer
	#
	# Instantiates the router for the module.
	App.addInitializer ->
		new MuppetsModule.Router
			controller: API
