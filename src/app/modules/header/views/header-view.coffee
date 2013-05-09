define [
	'text!modules/header/templates/header.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	# Define HeaderView class
	class HeaderView extends Framework.ItemView
		# Set View template
		template: template

	# Return HeaderView object (because this is a RequireJS module)
	return HeaderView