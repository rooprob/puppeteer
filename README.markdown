# Backbone.Marionette Boilerplate

This is a boilerplate project to build stuff using [Backbone.Marionette](http://marionettejs.com "Marionette.js – A scalable and composite application architecture for Backbone.js"). Some other funny names involved are: [Require.js](http://requirejs.org "RequireJS"), [Bower](http://twitter.github.com/bower/ "BOWER"), [Mocha](ub.io/mocha/), [Chai](http://chaijs.com "Home - Chai"), [Grunt.js](http://gruntjs.com "grunt: a task-based command line build tool for JavaScript projects"), [LESS](http://lesscss.org "LESS &laquo; The Dynamic Stylesheet language").

## Dependencies

* Client-side dependencies are managed using [Bower](http://twitter.github.com/bower/ "BOWER") so install it with `npm install -g bower`. After that, you can install all dependencies using: `bower install`
* [Grunt.js](http://gruntjs.com "grunt: a task-based command line build tool for JavaScript projects") is used to automatize tasks, so be sure to install it: `npm install -g grunt-cli`
* You can install Node.js dependencies using: `npm install`
* [PhantomJS](http://phantomjs.org "PhantomJS: Headless WebKit with JavaScript API") is used to run the tests suite. On OSX you can install it via Homebrew: `brew install phantomjs`

## Grunt.js tasks

* `default`: Runs `dev` task and start an HTTP server using `connect:dev` task
* `dev`: Cleans `/dev`, compiles CoffeScript and LESS files under `/src` to `/dev`
* `production`: Cleans `/production`, compiles CoffeScript files under `/src` to `/dev`, runs the tests suite, compiles LESS files under `/src` to `/production` and optimize all JS files under `/dev` to `/production` using RequireJS
* `test`: compiles CoffeScript files under `/src` to `/dev`, launch an HTTP server using `connect:test` task and run all tests under `/dev/test`
* `watch`: Watches changes on CoffeeScript and LESS files to run appropiate tasks (for test files you should have a running test HTTP server with `grunt connect:dev` or `grunt` default task)