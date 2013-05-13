define [
	'modules/header/controllers/show-controller'
	'app.framework'
	'communication-bus'
], (ShowController, Framework, CommunicationBus) ->

	# Define HeaderModule class
	class HeaderModule extends Framework.Module

		# This initialize method will execute on instantiation of this class
		initialize: (region) ->
			# Instantiate ShowController, passing the region it will belong
			# this region is passed on module instantiation
			new ShowController region: region

	# Register Module's start command
	CommunicationBus.commands.setHandler "module:header:start", (region) ->
		new HeaderModule region