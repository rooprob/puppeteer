define [
	'text!modules/other/templates/show.html'
	'app.framework'
], (template, Framework) ->

	class ShowView extends Framework.ItemView
		template: template

	return ShowView