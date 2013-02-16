require.config({
  urlArgs: 'bust=' + (new Date()).getTime(),
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

    'jasmine': '../../components/jasmine/lib/jasmine-core/jasmine',
    'jasmine-html': '../../components/jasmine/lib/jasmine-core/jasmine-html',
    'jasmine-jquery': '../../components/jasmine-jquery/lib/jasmine-jquery',
    'specs': '../../test/specs'
  },

  shim: {
    'jasmine': {
      exports: 'jasmine'
    },
    'jasmine-html': {
      deps: ['jasmine'],
      exports: 'jasmine'
    },
    'jasmine-jquery': {
      deps: ['jquery', 'jasmine']
    }
  }
});

require(['jquery', 'jasmine-html', 'specs', 'jasmine-jquery'], function($, jasmine, specs) {
  var jasmineEnv = jasmine.getEnv();
  var htmlReporter = new jasmine.HtmlReporter();

  jasmineEnv.updateInterval = 1000;
  jasmineEnv.addReporter(htmlReporter);

  jasmine.getFixtures().fixturesPath = 'fixtures/';
  jasmine.getJSONFixtures().fixturesPath = 'fixtures/json/';
  jasmine.getStyleFixtures().fixturesPath = 'fixtures/css/';

  $(function() {
    require(specs, function() {
      jasmineEnv.execute();
    });
  });
});