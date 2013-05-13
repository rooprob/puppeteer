define [
	'text!modules/other/templates/show.html'
	'app.framework'
	'communication-bus'
], (template, Framework, CommunicationBus) ->

	class ShowView extends Framework.ItemView
		template: template

	return ShowView