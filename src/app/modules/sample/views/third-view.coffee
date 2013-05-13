define [
	'text!modules/sample/templates/third.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	class ThirdView extends Framework.ItemView
		template: template
		triggers:
			"click #button-go-to-second" : "button-go-to-second:clicked"

	return ThirdView