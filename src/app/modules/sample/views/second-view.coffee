define [
	'text!modules/sample/templates/lorem.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	# Define SecondView class
	class SecondView extends Framework.ItemView
		# Set View template
		template: template

		# Set View event triggers. When clicking on #click-me template item
		# a "click-me:clicked" event will trigger.
		# See: http://goo.gl/zlZqj
		triggers:
			"click #click-me" : "click-me:clicked"

	# Return SecondView object (because this is a RequireJS module)
	return SecondView