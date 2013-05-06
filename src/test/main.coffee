require.config
	paths:
		'text': '../../lib/requirejs-text/text',
		'tpl': '../../lib/requirejs-tpl/tpl',
		'jquery': '../../lib/jquery/jquery',
		'bootstrap': '../../lib/bootstrap/docs/assets/js/bootstrap.min',
		'underscore': '../../lib/underscore-amd/underscore',
		'backbone': '../../lib/backbone-amd/backbone',
		'backbone.wreqr': '../../lib/backbone.wreqr/lib/amd/backbone.wreqr',
		'backbone.eventbinder': '../../lib/backbone.eventbinder/lib/amd/backbone.eventbinder',
		'backbone.babysitter': '../../lib/backbone.babysitter/lib/amd/backbone.babysitter',
		'marionette': '../../lib/marionette/lib/core/amd/backbone.marionette',
		'cfg': './config/config'

		'chai' : '../../lib/chai/chai',
		'sinon-chai' : '../../lib/sinon-chai/lib/sinon-chai',
		'sinon' : '../../lib/sinon/index',
		'js-fixtures' : '../../lib/js-fixtures/index'
	shim:
		'bootstrap': ['jquery']
		'cfg': ['./config/marionette/marionette-template-cache']

require ['chai', 'sinon-chai', 'sinon', 'js-fixtures'], (chai, sinonChai, sinon, fixtures) ->
	mocha.setup 'bdd'
	chai.should()
	chai.use sinonChai

	fixtures.path = 'dev/test/fixtures/'

	require [
		'specs/sample-spec'
	], ->
		mocha.run()