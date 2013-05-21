define ['framework/entities/model', 'backbone'], (Model, Backbone) ->

	describe "Framework.Model", ->

		it "should be an instance of Backbone.Model", ->
			model = new Model
			model.should.be.an.instanceof Backbone.Model