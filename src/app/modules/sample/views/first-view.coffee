define [
	'text!modules/sample/templates/first.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	class FirstView extends Framework.ItemView
		template: template
		triggers:
			"click #button-go-to-second" : "button-go-to-second:clicked"

	return FirstView