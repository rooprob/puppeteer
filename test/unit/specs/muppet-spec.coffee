describe 'Application', ->
  it 'expects a global variable for the namespace', ->
    expect(App).to.exist

  it 'expects a marionette application', ->
    expect(App).to.be.an('object')

  it 'expect all namespace properties are present', ->
    expect(App).to.include.keys(
      'Controllers', 'Controllers', 'Entities',
      'Utilities', 'Views',
      'HeaderModule', 'MuppetsModule',
    )

  it 'expects Entities to be an object', ->
    expect(App.Entities).to.be.an('object')

  describe 'Initialization', ->

    beforeEach ->
      this.muppets = App.request('muppet:entities')

    describe 'Collection of objects', ->

      it 'should be Muppets', ->
        expect(this.muppets).to.include.keys(
          'models', 'length'
        )

      it 'should have length 15', ->
        expect(this.muppets).length.to.be(15)

      it 'last pushed should be Waldorf', ->
        muppet = this.muppets.pop()
        expect(muppet.get('name')).to.be.equal('Waldorf')

    describe 'A single entity', ->

      it 'id 10 should be Fozzie Bear', ->
        muppet = App.request('muppet:entity', 10)
        expect(muppet.get('name')).to.be.equal('Fozzie Bear')

    describe 'A list of friends', ->

      describe 'friends of 10 should be 6,7,15', ->
        friends = App.request('muppet:friends', 10)

        describe 'friends', ->
          it 'friend is Rowlf', ->
            expect(friends.models[0].get('name')).to.be.equal('Rowlf the Dog')
          it 'friend is Miss Piggy', ->
            expect(friends.models[1].get('name')).to.be.equal('Miss Piggy')
          it 'friend is Waldorf', ->
            expect(friends.models[2].get('name')).to.be.equal('Waldorf')

