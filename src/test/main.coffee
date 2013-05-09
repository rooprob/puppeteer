require.config
	baseUrl: './dev/app'
	paths:
		'text': '../../lib/requirejs-text/text'
		'jquery': '../../lib/jquery/jquery'
		'bootstrap': '../../lib/bootstrap/docs/assets/js/bootstrap.min'
		'underscore': '../../lib/underscore-amd/underscore'
		'backbone': '../../lib/backbone-amd/backbone'
		'backbone.wreqr': '../../lib/backbone.wreqr/lib/amd/backbone.wreqr'
		'backbone.babysitter': '../../lib/backbone.babysitter/lib/amd/backbone.babysitter'
		'marionette': '../../lib/marionette/lib/core/amd/backbone.marionette'
		'cfg': './config/config'

		'chai' : '../../lib/chai/chai'
		'sinon-chai' : '../../lib/sinon-chai/lib/sinon-chai'
		'sinon' : '../../lib/sinon/index'
		'js-fixtures' : '../../lib/js-fixtures/index'
		'specs' : '../test/specs'
	shim:
		'bootstrap': ['jquery']

require [
	'chai'
	'sinon-chai'
	'js-fixtures'
	'sinon'
	'cfg'
	'bootstrap'
], (chai, sinonChai, fixtures) ->
	mocha.setup 'bdd'
	chai.should()
	chai.use sinonChai

	fixtures.path = 'dev/test/fixtures/'

	require [
		'specs/sample-spec'
	], ->
		mocha.run()