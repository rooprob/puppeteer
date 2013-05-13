define [
	'text!modules/header/templates/header.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	class HeaderView extends Framework.ItemView
		template: template
		ui:
			sampleModuleLink : '#sample-module-link'
			otherModuleLink : '#other-module-link'

	return HeaderView