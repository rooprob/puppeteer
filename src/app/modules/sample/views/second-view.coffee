define [
	'text!modules/sample/templates/lorem.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	class SecondView extends Framework.ItemView
		template: template
		triggers:
			"click #click-me" : "click-me:clicked"
		animations:
			render: 'fadeIn'
			close: 'fadeOut'

	return SecondView