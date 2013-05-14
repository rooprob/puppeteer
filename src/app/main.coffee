require.config
	paths:
		'text': '../../lib/requirejs-text/text'
		'jquery': '../../lib/jquery/jquery'
		'bootstrap': '../../lib/bootstrap/docs/assets/js/bootstrap.min'
		'underscore': '../../lib/underscore-amd/underscore'
		'backbone': '../../lib/backbone-amd/backbone'
		'backbone.wreqr': '../../lib/backbone.wreqr/lib/amd/backbone.wreqr'
		'backbone.babysitter': '../../lib/backbone.babysitter/lib/amd/backbone.babysitter'
		'marionette': '../../lib/marionette/lib/core/amd/backbone.marionette'
		'app.framework': './framework/framework'
		'communication-bus': './framework/communication-bus'
	shim:
		'bootstrap': ['jquery']

require ['jquery', 'app', 'bootstrap'], ($, App) ->
	$ ->
		App.start()