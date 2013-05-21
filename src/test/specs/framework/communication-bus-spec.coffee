define ['communication-bus', 'backbone.wreqr'], (CommunicationBus, Wreqr) ->

	describe "CommunicationBus", ->

		it "Should have a 'vent', 'commands' and 'reqres' attributes", ->
			CommunicationBus.vent.should.exist
			CommunicationBus.commands.should.exist
			CommunicationBus.reqres.should.exist

			CommunicationBus.vent.should.be.instanceof Wreqr.EventAggregator
			CommunicationBus.commands.should.be.instanceof Wreqr.Commands
			CommunicationBus.reqres.should.be.instanceof Wreqr.RequestResponse