define [
	'framework/application'
	'marionette'
	'backbone'
	'communication-bus'
], (Application, Marionette, Backbone, CommunicationBus) ->

	# BEFORE AND AFTER
	# --------------------------------------------------------------------------------------
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
	# --------------------------------------------------------------------------------------
	describe "Framework.Application", ->

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
				stub = @sandbox.stub CommunicationBus.commands, 'setHandler', ->
				application = new Application
				stub.should.have.been.calledWith "app:navigate"

			it "should attach registry handlers after initialization", ->
				stub = @sandbox.stub CommunicationBus.commands, 'setHandler', ->
				application = new Application
				stub.should.have.been.calledWith "register:instance"
				stub.should.have.been.calledWith "unregister:instance"
				stub.should.have.been.calledWith "reset:instances"

		# History
		# ------------------------------------------------------------------------------------
		describe "History", ->

			# attachHandlers()
			# ----------------------------------------------------------------------------------
			describe "attachHandlers()", ->
				it "should create an 'app:navigate' event listener on attachHandlers", ->
					stub = @sandbox.stub CommunicationBus.commands, 'setHandler', ->
					@application.history.attachHandlers()
					stub.should.have.been.calledWith 'app:navigate'

				it "should call history.navigate on 'app:navigate' command", ->
					stub = @sandbox.stub @application.history, 'navigate', ->
					CommunicationBus.commands.execute 'app:navigate', 'sample/route', foo: 'bar'
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
			#startHistory: ->
			#	Backbone.history.start() if Backbone.history
				it "should start Backbone history", ->
					@application.history.startHistory()
					@historyStartStub.should.have.been.called

		# Registry
		# ------------------------------------------------------------------------------------
		describe "Registry", ->

			# attachHandlers()
			# ----------------------------------------------------------------------------------
			describe "attachHandlers()", ->
				it "should register a 'register:instance' command", ->
					stub = @sandbox.stub CommunicationBus.commands, 'setHandler', ->
					@application.registry.attachHandlers()
					stub.should.have.been.calledWith 'register:instance'

				it "should register a 'unregister:instance' command", ->
					stub = @sandbox.stub CommunicationBus.commands, 'setHandler', ->
					@application.registry.attachHandlers()
					stub.should.have.been.calledWith 'unregister:instance'

				it "should register a 'reset:instances' command", ->
					stub = @sandbox.stub CommunicationBus.commands, 'setHandler', ->
					@application.registry.attachHandlers()
					stub.should.have.been.calledWith 'reset:instances'

				it "should add an instance on 'register:instance' command", ->
					stub = @sandbox.stub @application.registry, 'add', ->
					CommunicationBus.commands.execute 'register:instance', 1, 2
					stub.should.have.been.calledWith 1, 2

				it "should remove instance on 'unregister:instance' command", ->
					stub = @sandbox.stub @application.registry, 'remove', ->
					CommunicationBus.commands.execute 'unregister:instance', 1
					stub.should.have.been.calledWith 1

				it "should reset instances on 'reset:instances' command", ->
					stub = @sandbox.stub @application.registry, 'reset', ->
					CommunicationBus.commands.execute 'reset:instances'
					stub.should.have.been.called


			# add()
			# ----------------------------------------------------------------------------------
			describe "add()", ->
				it "should add a new item to the registry", ->
					should = require('chai').should()
					application = new Application
					application.registry._registry = {}
					application.registry.add 1, 2
					application.registry._registry[2].should.equal 1

			# remove()
			# ----------------------------------------------------------------------------------
			describe "remove()", ->
				it "should remove items from the registry", ->
					should = require('chai').should()
					application = new Application
					application.registry._registry = {}
					application.registry.add 1, 2
					should.exist application.registry._registry[2]
					application.registry.remove 2
					should.not.exist application.registry._registry[2]

			# reset()
			# ----------------------------------------------------------------------------------
			describe "reset()", ->
				beforeEach ->
					@mockController =
						region:
							close: ->

				afterEach ->
					@mockController = null

				it "should close regions for all registry items", ->
					spy = @sandbox.spy @mockController.region, 'close'
					application = new Application
					application.registry.add @mockController, 1
					application.registry.add @mockController, 2
					application.registry.add @mockController, 3
					application.registry.reset()
					spy.should.have.been.calledThrice

				it "should console.warn if there are remaining items on the registry", ->
					stub = @sandbox.stub console, 'warn', ->
					application = new Application
					application.registry.add @mockController, 1
					application.registry.add @mockController, 2
					application.registry.add @mockController, 3
					application.registry.reset()
					stub.should.have.been.called

				it "should console.log if there are not remaining items on the registry", ->
					stub = @sandbox.stub console, 'warn', ->
					application = new Application
					application.registry.reset()
					stub.should.have.been.called

			# getSize()
			# ----------------------------------------------------------------------------------
			describe "getSize()", ->
				it "should return registry size", ->
					application = new Application
					application.registry._registry = {}
					application.registry.add 1, 2
					application.registry.add 1, 3
					application.registry.getSize().should.equal 2