require.config({
  baseUrl: '/app/js',
  paths: {
    'text': '../../components/requirejs-text/text',
    'tpl': '../../components/requirejs-tpl/tpl',
    'jquery': '../../components/jquery/jquery',
    'underscore': '../../components/underscore-amd/underscore',
    'backbone': '../../components/backbone-amd/backbone',
    'backbone.wreqr': '../../components/backbone.wreqr/lib/amd/backbone.wreqr',
    'backbone.eventbinder': '../../components/backbone.eventbinder/lib/amd/backbone.eventbinder',
    'backbone.babysitter': '../../components/backbone.babysitter/lib/amd/backbone.babysitter',
    'marionette': '../../components/marionette/lib/core/amd/backbone.marionette',
    'cfg': './config/config'
  },
  shim: {
    'cfg': {
      'deps': [
        './config/marionette/marionette-template-cache'
      ]
    }
  }
});

require(['modules/app/app-module', 'jquery', 'cfg'], function(App, $) {
  $(function() {
    App.start();
  });
});