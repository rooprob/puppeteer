# Puppeteer v1.0.0

Development stack to build web stuff using [Marionette](http://marionettejs.com
"Marionette.js – A scalable and composite application architecture for Backbone.js"). Some other funny names involved are:

* [GruntJS](http://gruntjs.com "Grunt: The Javascript Task Runner")
* [CoffeeScript](http://coffeescript.org)
* [Compass](http://compass-style.org "Compass: an open-source CSS Authoring Framework.")
* [Mocha](http://visionmedia.github.io/mocha/ "The fun, simple, flexible Javascript test framework")
* [Handlebars](http://handlebarsjs.com "Minimal Templating on Steroids")

## First steps

You have two options for using Puppeteer:

* Clone this repo to see an example project using the stack
* Use the [Yeoman generator](https://github.com/puppeteer/generator-puppeteer)
  to generate your new project and code

If you choose the first, follow these steps:

* Clone the repo: `git clone https://github.com/puppeteer/puppeteer.git
  my-awesome-project` and `cd my-awesome-project`
* Make sure you remove `.git/` folder, because you would like to have your own
  versioning, isn't it?
* Edit the `README.markdown` file, because you should put your own instructions
  there!
* Install needed NPM packages for dev purposes: `npm install`
* Remember that you should have Grunt, Bower and some other NPM packages
  installed globally
* Install project dependencies: `bower install`
* Install [Ruby](https://www.ruby-lang.org/en/downloads "Download Ruby"),
  [Sass](http://sass-lang.com/install "Sass: Install Sass"), and
  [Compass](http://compass-style.org/install "Install the Compass Stylesheet Authoring Framework")
  if you don't have them already
* Run your Grunt default task: `grunt`
* Open your browser and your editor and see the example project:
  `http://localhost:3000/dist/`
* Once you are comfortable with the code structure, remove the sample code and
  start coding your own!

## Example project

The example project is just a showcase of how we like to structure code on this
stack. It show how we use __modules__ and __actions__ inside them.

It also shows the use of __entities__ and __components__, and the way the app
communicates with them to work.

The project showcase a filterable list of
[Muppets](http://en.wikipedia.org/wiki/The_Muppets), and a view page for each
of them.

## Folder structure

* `./dist/`: Generated files, ready to be used
* `./src/`: The source code of your app
  * `./src/index.html`: App web page, the entry point!
  * `./src/javascript.coffee`: Your main source file, it includes every other
    one
  * `./src/styles.scss`: The main styles file for your app. This file should
    include the partials under `./src/styles/`
  * `./src/app/`: Your fabulous app
    * `./src/app/app.coffee`: The file for the main object of your App, the
      namespace
    * `./src/app/entities/`: Entities (Collections and Models) used on the app
    * `./src/app/lib/`: Code related with the behaviour of your app. Think of
      it like a config for your app objects, not frameworks
    * `./src/app/modules/`: Modules that you will use to build your app:
      HeaderModule, FooterModule, KittensModule and so on
  * `./src/config/`: Config files for your frameworks: Backbone, jQuery…
  * `./src/images/`: Images used in your app
  * `./src/styles/`: Sass styles for the app (with Compass!). Here we should
    have the partials styles for our app
* `./test/`: Test suites
  * `./test/functional`: Functional tests with CasperJS
  * `./test/unit`: Unit tests with Mocha, Chai and Sinon
    * `./test/unit/test.coffee`: Include your unit tests on this file
    * `./test/unit/specs/`: Your awesome unit tests to ensure the quality of
      your app
* `./vendor/`: Dependencies downloaded by Bower

## Grunt tasks

* `grunt`: Default task. Executes `grunt dev` (see next point), launch an HTTP server on port `3000` and watch for changes on files
* `grunt dev`: Compiles source files for dev purposes (without minification…)
* `grunt production`: Compiles source files for production (minification, concatenates into single JS and CSS files…)

## Caution

This is an extremely personal stack, with an extremely personal way of doing
things. I feel comfortable doing stuff this way, but I change my mind easily.
So if you have something to suggest, please do it. Fork it, change it, adapt
it, enlighten me with better ways of doing things.

## Contribute

If you want to show us something cool that you think it could fit in this
stack, please send us a pull request with your changes.

* Fork the project
* Create your feature branch (`git checkout -b my-feature`)
* Do your changes (don't forget the tests suite if needed)
* Remember that we use [EditorConfig](http://editorconfig.org) to keep coding
  standards in our files. Please use it too, or follow the rules described in
  the `.editorconfig` file.
* Commit your changes (`git commit -am 'Awesome feature added'`)
* Push to the server (`git push origin my-feature`)
* Send the pull request!
