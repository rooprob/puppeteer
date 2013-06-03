define [
	'framework/application'
	'marionette'
	'backbone'
	'communication-bus'
], (Application, Marionette, Backbone, Bus) ->

	describe "Framework.Application", ->

		# BEFORE AND AFTER
		# ------------------------------------------------------------------------------------
		before ->
			@historyStartStub = sinon.stub Backbone.history, 'start', ->

		beforeEach ->
			@sandbox = sinon.sandbox.create()
			@application = new Application

		afterEach ->
			@application = null
			@sandbox.restore()

		after ->
			Backbone.history.start.restore()


		# SPECS
		# ------------------------------------------------------------------------------------

		# Global
		# ------------------------------------------------------------------------------------
		describe "Global", ->
			it "should be an instance of Marionette.Application", ->
				@application.should.be.an.instanceof Marionette.Application

		# Initialize
		# ------------------------------------------------------------------------------------
		describe "Initialize", ->
			it "should start history after initialization", ->
				stub = @sandbox.stub @application.history, 'startHistory', ->
				@application.trigger 'initialize:after'
				stub.should.have.been.called

			it "should navigate to rootRoute after initialization if no current route", ->
				@sandbox.stub @application.history, 'getCurrentRoute', ->
					return null

				stub = @sandbox.stub @application.history, 'navigate', ->
				@application.rootRoute = 'sample/route'
				@application.trigger 'initialize:after'
				stub.should.have.been.calledWith 'sample/route', trigger: true

			it "should attach history handlers after initialization", ->
				stub = @sandbox.stub Bus.commands, 'setHandler', ->
				application = new Application
				stub.should.have.been.calledWith "app:navigate"

		# History
		# ------------------------------------------------------------------------------------
		describe "History", ->

			# attachHandlers()
			# ----------------------------------------------------------------------------------
			describe "attachHandlers()", ->
				it "should create an 'app:navigate' event listener on attachHandlers", ->
					stub = @sandbox.stub Bus.commands, 'setHandler', ->
					@application.history.attachHandlers()
					stub.should.have.been.calledWith 'app:navigate'

				it "should call history.navigate on 'app:navigate' command", ->
					stub = @sandbox.stub @application.history, 'navigate', ->
					Bus.commands.execute 'app:navigate', 'sample/route', foo: 'bar'
					stub.should.have.been.calledWith 'sample/route', foo: 'bar'

			# navigate()
			# ----------------------------------------------------------------------------------
			describe "navigate()", ->
				it "should call Backbone.history.navigate", ->
					route = 'sample/route'
					opts = foo: 'bar'
					stub = @sandbox.stub Backbone.history, 'navigate', ->
					@application.history.navigate route, opts
					stub.should.have.been.calledWith route, opts

				it "should prepend route if it starts with '/'", ->
					route = '/sample/route'
					opts = foo: 'bar'
					stub = @sandbox.stub Backbone.history, 'navigate', ->
					@application.history.navigate route, opts
					stub.should.have.been.calledWith '#'+ route, opts

			# getCurrentRoute()
			# ----------------------------------------------------------------------------------
			describe "navigate()", ->
				it "should return the current route", ->
					Backbone.history.fragment = 'sample/route'
					@application.history.getCurrentRoute().should.equal 'sample/route'

				it "should return null if there is no current route", ->
					should = require('chai').should()
					Backbone.history.fragment = ''
					currentRoute = @application.history.getCurrentRoute()
					should.not.exist currentRoute

			# setRootRoute()
			# ----------------------------------------------------------------------------------
			describe "setRootRoute()", ->
				it "should set history.rootRoute instance property", ->
					should = require('chai').should()
					route = 'sample/route'
					should.not.exist @application.history.rootRoute
					@application.history.setRootRoute route
					@application.history.rootRoute.should.equal route

			# startHistory()
			# ----------------------------------------------------------------------------------
			describe "startHistory()", ->
				it "should start Backbone history", ->
					@application.history.startHistory()
					@historyStartStub.should.have.been.called
