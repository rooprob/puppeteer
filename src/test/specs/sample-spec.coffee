define ['backbone'], (backbone) ->
	describe 'Sample spec', ->
		it 'sample equal assertion', ->
			"Foo".should.equal "Foo"

		it 'sample RequireJS import', ->
			backbone.should.exist

		it 'sample async', (done) ->
			async = ->
				1.should.equal 1
				done()

			setTimeout async, 1000