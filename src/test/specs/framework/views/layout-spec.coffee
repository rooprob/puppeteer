define ['framework/views/layout', 'marionette'], (Layout, Marionette) ->

	describe "Framework.Layout", ->
		it "should be an instance of Marionette.Layout", ->
			view = new Layout
			view.should.be.an.instanceof Marionette.Layout