define [
	'text!modules/header/templates/header.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	class HeaderView extends Framework.ItemView
		template: template
		animations:
			render: 'fadeIn'

	return HeaderView