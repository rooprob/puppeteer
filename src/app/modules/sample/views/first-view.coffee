define [
	'text!modules/sample/templates/content.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	# Define FirstView class
	class FirstView extends Framework.ItemView
		# Set View template
		template: template

		# Set View event triggers. When clicking on #click-me template item
		# a "click-me:clicked" event will trigger.
		# See: http://goo.gl/zlZqj
		triggers:
			"click #click-me" : "click-me:clicked"

	# Return FirstView object (because this is a RequireJS module)
	return FirstView