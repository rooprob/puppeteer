define ['framework/collection', 'backbone'], (Collection, Backbone) ->

	describe "Framework.Collection", ->
		it "should be an instance of Backbone.Collection", ->
			collection = new Collection
			collection.should.be.an.instanceof Backbone.Collection