define [
	'text!modules/sample/templates/second.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	# Define SecondView class
	class SecondView extends Framework.ItemView
		# Set View template
		template: template

		# Set View event triggers. When clicking on #click-me template item
		# a "click-me:clicked" event will trigger, and when clicking on
		# #go-ahead, a "go-ahead:clicked" event will trigger.
		# See: http://goo.gl/zlZqj
		triggers:
			"click #button-go-to-first" : "button-go-to-first:clicked"
			"click #button-go-to-third" : "button-go-to-second:clicked"

	# Return SecondView object (because this is a RequireJS module)
	return SecondView