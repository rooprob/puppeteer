define ['framework/views/collectionview', 'marionette'], (CollectionView, Marionette) ->

	describe "Framework.CollectionView", ->

		it "should be an instance of Marionette.CollectionView", ->
			view = new CollectionView
			view.should.be.an.instanceof Marionette.CollectionView