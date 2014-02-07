`
//= require "../vendor/mocha/mocha.js"
//= require "../vendor/chai/chai.js"
//= require "../vendor/sinon-chai/lib/sinon-chai.js"
//= require "../vendor/sinon/lib/sinon.js"

`
chai.should()
mocha.setup 'bdd'
expect = chai.expect

#= require "specs/sample-spec.coffee"

mocha.run()
