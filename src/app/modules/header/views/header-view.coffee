define [
	'text!modules/header/templates/header.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	# Define HeaderView class
	class HeaderView extends Framework.ItemView
		# Set View template
		template: template

		ui:
			sampleModuleLink : '#sample-module-link'
			otherModuleLink : '#other-module-link'

	# Return HeaderView object (because this is a RequireJS module)
	return HeaderView