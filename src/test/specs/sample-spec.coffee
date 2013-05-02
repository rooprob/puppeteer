define ['backbone'], (backbone) ->
  describe 'Sample spec', ->
    it 'sample equal assertion', ->
      "Foo".should.equal "Foo"

    it 'sample RequireJS import', ->
      backbone.should.exist