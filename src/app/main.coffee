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
  shim:
    'cfg':
      'deps': [
        './config/marionette/marionette-template-cache'
      ]

require ['modules/app/app-module', 'jquery', 'cfg'], (App, $) ->
  $ ->
    App.start()