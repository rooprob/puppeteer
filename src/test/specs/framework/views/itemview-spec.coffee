define ['framework/views/itemview', 'marionette'], (ItemView, Marionette) ->

	describe "Framework.ItemView", ->

		it "should be an instance of Marionette.ItemView", ->
			view = new ItemView
			view.should.be.an.instanceof Marionette.ItemView