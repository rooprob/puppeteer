define [
	'text!modules/sample/templates/first.html'
	'app.framework'
], (template, Framework) ->

	class FirstView extends Framework.ItemView
		template: template
		triggers:
			"click #button-go-to-second" : "button-go-to-second:clicked"

	return FirstView