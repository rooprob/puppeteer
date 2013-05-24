define [
	'text!modules/sample/templates/second.html'
	'app.framework'
], (template, Framework) ->

	class SecondView extends Framework.ItemView
		template: template
		triggers:
			"click #button-go-to-first" : "button-go-to-first:clicked"
			"click #button-go-to-third" : "button-go-to-second:clicked"

	return SecondView