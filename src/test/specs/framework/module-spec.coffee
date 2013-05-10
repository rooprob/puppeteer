define ['framework/module', 'marionette'], (Module, Marionette) ->

	describe "Framework.Module", ->
		it "should call initialize() method on instantiation", ->
			class TestModule extends Module
				initialize: (val) ->
					console.log val

			spyInitialize = sinon.spy TestModule::, 'initialize'
			spyLog = sinon.spy console, 'log'
			module = new TestModule 1

			spyInitialize.should.have.been.calledWith 1
			spyLog.should.have.been.calledWith 1

			console.log.restore()