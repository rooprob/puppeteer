# Puppeteer

Development stack to build web stuff using [Marionette](http://marionettejs.com
"Marionette.js – A scalable and composite application architecture for
Backbone.js"). Some other funny names involved are:

* [GruntJS](http://gruntjs.com "Grunt: The Javascript Task Runner")
* [CoffeeScript](http://coffeescript.org)
* [Compass](http://compass-style.org "Compass: an open-source CSS Authoring Framework.")
* [Mocha](http://visionmedia.github.io/mocha/ "The fun, simple, flexible Javascript test framework")
* [Handlebars](http://handlebarsjs.com "Minimal Templating on Steroids")

## Caution

This is an extremely personal stack, with an extremely personal way of doing
things. I feel comfortable doing stuff this way, but I change my mind easily. So
if you have something to suggest, please do it. Fork it, change it, adapt it,
enlighten me with better ways of doing things.

## First steps

* Make sure you remove `.git/` folder, because you would like to have your own
	versioning, isn't it?
* Install needed NPM packages for dev purposes: `npm install`
* Remember that you should have Grunt, Bower and some other NPM packages
	installed globally
* Install project dependencies: `bower install`
* Install [Ruby](https://www.ruby-lang.org/en/downloads "Download Ruby"),
	[Sass](http://sass-lang.com/install "Sass: Install Sass"), and
	[Compass](http://compass-style.org/install "Install the Compass Stylesheet Authoring Framework")
* Run your Grunt default task: `grunt`
* Open your browser and your editor and start coding:
	`http://localhost:3000/dist/`

## Folder structure

* `./dist/`: Generated files, ready to be used
* `./src/`: The source code of your app
	* `./src/index.html`: App web page, the entry point!
	* `./src/javascript.coffee`: Your main source file, it includes every other
		one
	* `./src/app/`: Your fabulous app
		* `./src/app/app.coffee`: The file for the main object of your App, the
			namespace
		* `./src/app/entities/`: Entities (Collections and Models) used on the app
		* `./src/app/lib/`: Code related with the behaviour of your app. Think of it
			like a config for your app objects, not frameworks
		* `./src/app/modules/`: Modules that you will use to build your app:
			HeaderModule, FooterModule, KittensModule and so on
	* `./src/config/`: Config files for your frameworks: Backbone, jQuery…
	* `./src/images/`: Images used in your app
	* `./src/styles/`: Sass styles for the app (with Compass!)
* `./test/`: Test suites
	* `./test/functional`: Functional tests with CasperJS
	* `./test/unit`: Unit tests with Mocha, Chai and Sinon
		* `./test/unit/test.coffee`: Include your unit tests on this file
		* `./test/unit/specs/`: Your awesome unit tests to ensure the quality of
			your app
* `./vendor/`: Dependencies downloaded by Bower
