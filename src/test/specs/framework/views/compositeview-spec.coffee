define ['framework/views/compositeview', 'marionette'], (CompositeView, Marionette) ->

	describe "Framework.CompositeView", ->
		it "should be an instance of Marionette.CompositeView", ->
			view = new CompositeView
			view.should.be.an.instanceof Marionette.CompositeView