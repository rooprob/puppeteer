define [
	'framework/module'
	'marionette'
	'communication-bus'
	'framework/router'
], (Module, Marionette, Bus, AppRouter) ->

	describe "Framework.Module", ->

		# BEFORE AND AFTER
		# ------------------------------------------------------------------------------------
		beforeEach ->
			@sandbox = sinon.sandbox.create()

		afterEach ->
			@sandbox.restore()

		# SPECS
		# ------------------------------------------------------------------------------------

		# Global
		# ------------------------------------------------------------------------------------
		describe 'Global', ->

			it "should call initialize() method on instantiation", ->
				class TestModule extends Module
					initialize: (val) ->
						console.log val

				spyInitialize = @sandbox.spy TestModule::, 'initialize'
				spyLog = @sandbox.spy console, 'log'
				module = new TestModule 1

				spyInitialize.should.have.been.calledWith 1
				spyLog.should.have.been.calledWith 1

		# setRoutes
		# ------------------------------------------------------------------------------------
		describe 'Routes', ->

			describe "setRoutes()", ->

				beforeEach ->
					@module = new Module
					@module.setRoutes
						'sample/route' : ->

				it "should create a new AppRouter with given routes", ->
					@module.router.routes['sample/route'].should.exist

				it "should set Module router object", ->
					@module.router.should.exist
					@module.router.should.be.instanceof AppRouter

		# Close
		# ------------------------------------------------------------------------------------
		describe 'Close', ->

			it "should stop listening to router methods", ->
				module = new Module
				module.setRoutes
					'sample/route' : ->

				spy = @sandbox.spy module.router, 'stopListening'

				module.close()

				spy.should.have.been.called


			it "should call the reset of all messaging objects", ->
				module = new Module

				spyResetCommands = @sandbox.spy(module, 'resetCommands')
				spyResetRequests = @sandbox.spy(module, 'resetRequests')
				spyResetEvents = @sandbox.spy(module, 'resetEvents')

				module.close()

				spyResetCommands.should.have.been.called
				spyResetRequests.should.have.been.called
				spyResetEvents.should.have.been.called

		# Commands
		# ------------------------------------------------------------------------------------
		describe 'Commands', ->

			describe "resetCommands()", ->
				it "should remove all command handlers", ->
					module = new Module
					module.setCommands
						'sample:command1': -> console.log 'Callback'
						'sample:command2': -> console.log 'Callback'

					module.resetCommands()

					module._commands.length.should.equal 0
					Bus.commands.hasHandler('sample:command1').should.be.false
					Bus.commands.hasHandler('sample:command2').should.be.false

			describe "setCommands()", ->
				it "should store command key for later use", ->
					module = new Module
					module.setCommands
						'sample:command1': ->
						'sample:command2': ->

					module._commands.should.include 'sample:command1'
					module._commands.should.include 'sample:command2'


				it "should add commands based on given object", ->
					spy1 = @sandbox.spy()
					spy2 = @sandbox.spy()
					module = new Module
					module.setCommands
						'sample:command1': spy1
						'sample:command2': spy2

					Bus.commands.execute 'sample:command1'
					Bus.commands.execute 'sample:command2'

					should = require('chai').should()

					should.exist Bus.commands.getHandler 'sample:command1'
					should.exist Bus.commands.getHandler 'sample:command2'

					spy1.should.have.been.called
					spy2.should.have.been.called

		# Requests
		# ------------------------------------------------------------------------------------
		describe 'Requests', ->

			describe "resetRequests()", ->
				it "should remove all request handlers", ->
					module = new Module
					module.setRequests
						'sample:request1': -> console.log 'Callback'
						'sample:request2': -> console.log 'Callback'

					module.resetRequests()

					module._requests.length.should.equal 0
					Bus.reqres.hasHandler('sample:request1').should.be.false
					Bus.reqres.hasHandler('sample:request2').should.be.false

			describe "setRequests()", ->
				it "should store request key for later use", ->
					module = new Module
					module.setRequests
						'sample:request1': ->
						'sample:request2': ->

					module._requests.should.include 'sample:request1'
					module._requests.should.include 'sample:request2'

				it "should add requests based on given object", ->
					spy1 = @sandbox.spy()
					spy2 = @sandbox.spy()
					module = new Module
					module.setRequests
						'sample:request1': spy1
						'sample:request2': spy2

					Bus.reqres.request 'sample:request1'
					Bus.reqres.request 'sample:request2'

					should = require('chai').should()

					should.exist Bus.reqres.getHandler 'sample:request1'
					should.exist Bus.reqres.getHandler 'sample:request2'

					spy1.should.have.been.called
					spy2.should.have.been.called

		# Events
		# ------------------------------------------------------------------------------------
		describe 'Events', ->

			describe "resetEvents()", ->
				it "should remove all event handlers", ->
					spy1 = @sandbox.spy()
					spy2 = @sandbox.spy()

					module = new Module
					module.setEvents
						'sample:event1': spy1
						'sample:event2': spy2

					module.resetEvents()
					Bus.vent.trigger 'sample:event1'
					Bus.vent.trigger 'sample:event2'

					module._events.length.should.equal 0
					spy1.should.not.have.been.called
					spy2.should.not.have.been.called

			describe "setEvents()", ->
				it "should store event key for later use", ->
					module = new Module
					module.setEvents
						'sample:event1': ->
						'sample:event2': ->

					module._events.should.include 'sample:event1'
					module._events.should.include 'sample:event2'

				it "should add events based on given object", ->
					spy1 = @sandbox.spy()
					spy2 = @sandbox.spy()
					module = new Module
					module.setEvents
						'sample:event1': spy1
						'sample:event2': spy2

					Bus.vent.trigger 'sample:event1'
					Bus.vent.trigger 'sample:event2'

					spy1.should.have.been.called
					spy2.should.have.been.called