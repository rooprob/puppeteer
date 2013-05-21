define ['framework/router', 'marionette'], (Router, Marionette) ->

	describe "Framework.Router", ->

		it "should be an instance of Marionette.AppRouter", ->
			router = new Router
			router.should.be.an.instanceof Marionette.AppRouter