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
		'app.framework': './framework/framework'
		'communication-bus': './framework/communication-bus'

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
	chai.use sinonChai
	chai.should()

	fixtures.path = 'dev/test/fixtures/'

	require [
		'specs/framework/application-spec'
		'specs/framework/collection-spec'
		'specs/framework/communication-bus-spec'
		'specs/framework/controller-spec'
		'specs/framework/framework-spec'
		'specs/framework/model-spec'
		'specs/framework/module-spec'
		'specs/framework/router-spec'
		'specs/framework/views/collectionview-spec'
		'specs/framework/views/compositeview-spec'
		'specs/framework/views/itemview-spec'
		'specs/framework/views/layout-spec'
		'specs/framework/views/view-spec'

		'specs/sample-spec'
	], ->

		mocha.run()