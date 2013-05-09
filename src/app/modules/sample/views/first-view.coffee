define [
	'text!modules/sample/templates/content.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	class FirstView extends Framework.ItemView
		template: template
		triggers:
			"click #click-me" : "click-me:clicked"
		animations:
			render: 'fadeIn'
			close: 'fadeOut'

	return FirstView