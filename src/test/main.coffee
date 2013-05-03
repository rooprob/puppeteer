require.config
	paths:
		'text': '../../lib/requirejs-text/text',
		'tpl': '../../lib/requirejs-tpl/tpl',
		'jquery': '../../lib/jquery/jquery',
		'underscore': '../../lib/underscore-amd/underscore',
		'backbone': '../../lib/backbone-amd/backbone',
		'backbone.wreqr': '../../lib/backbone.wreqr/lib/amd/backbone.wreqr',
		'backbone.eventbinder': '../../lib/backbone.eventbinder/lib/amd/backbone.eventbinder',
		'backbone.babysitter': '../../lib/backbone.babysitter/lib/amd/backbone.babysitter',
		'marionette': '../../lib/marionette/lib/core/amd/backbone.marionette',
		'cfg': './config/config'

		'chai' : '../../lib/chai/chai',
		'sinon-chai' : '../../lib/sinon-chai/lib/sinon-chai',
		'sinon' : '../../lib/sinon/index'
	shim:
		'cfg':
			'deps': []

require [
	'chai',
	'sinon-chai',
	'sinon'
], (chai, sinonChai, sinon) ->
	mocha.setup 'bdd'
	chai.should()
	chai.use(sinonChai);

	require [
		'specs/sample-spec'
	], ->
		mocha.run()