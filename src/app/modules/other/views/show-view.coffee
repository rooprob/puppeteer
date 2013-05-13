define [
	'text!modules/other/templates/show.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	# Define ShowView class
	class ShowView extends Framework.ItemView
		# Set View template
		template: template

	# Return ShowView object (because this is a RequireJS module)
	return ShowView