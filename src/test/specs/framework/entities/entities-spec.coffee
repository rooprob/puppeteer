define [
	'jquery'
	'backbone'
	'communication-bus'
	'framework/entities/entities'
], ($, Backbone, Bus) ->

	describe "Framework.Entities", ->

		# BEFORE AND AFTER
		# ----------------------------------------------------------------------------------
		beforeEach ->
			@sandbox = sinon.sandbox.create()
			@sandbox.useFakeServer()

		afterEach ->
			@sandbox.restore()

		# SPECS
		# ----------------------------------------------------------------------------------

		# Sync()
		# ------------------------------------------------------------------------------------
		describe "sync()", ->

			it "should attach a _fetchPromise attribute on entity fetch()", ->
				@sandbox.server.respondWith "GET", "/test", [ 200, {}, '{}']

				class Mock extends Backbone.Model
					url: '/test'

				mockEntity = new Mock

				mockEntity.fetch()

				should = require('chai').should()
				should.exist mockEntity._fetchPromise

			it "should trigger 'sync:start' and 'sync:stop' events on fetch()", ->
				spyStart = @sandbox.spy()
				spyStop = @sandbox.spy()
				@sandbox.server.respondWith "GET", "/test", [ 200, {}, '{}']

				class Mock extends Backbone.Model
					url: '/test'

				mockEntity = new Mock

				mockEntity.on 'sync:start', spyStart
				mockEntity.on 'sync:stop', spyStop

				mockEntity.fetch()

				spyStart.should.have.been.called
				spyStart.should.have.been.called

		# "when:fetched" command
		# ------------------------------------------------------------------------------------
		describe "'when:fetched' command handler", ->

			it "should define a 'when:fetched' command handler", ->
				should = require('chai').should()
				should.exist Bus.commands.getHandler 'when:fetched'

			it "should execute callback when all entities _fetchPromise are done", (done) ->
				cb = -> console.log 'Callback'
				spy = @sandbox.spy cb

				deferredMethod = ->
					deferred = $.Deferred()
					setTimeout ->
						deferred.resolve()
					, 5
					return deferred

				mockEntity1 =
					_fetchPromise: deferredMethod()

				mockEntity2 =
					_fetchPromise: deferredMethod()

				Bus.commands.execute 'when:fetched', [mockEntity1, mockEntity2], spy

				setTimeout ->
					spy.should.have.been.called
					done()
				, 15