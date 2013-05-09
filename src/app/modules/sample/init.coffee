define [
	'modules/sample/controllers/first-controller'
	'modules/sample/controllers/second-controller'
	'app.framework'
	'communication-bus'
], (FirstController, SecondController, Framework, CommunicationBus) ->

	class SampleModule extends Framework.Module
		initialize: (options = {}) =>
			@router = new Framework.AppRouter
				routes:
					"": =>
						new FirstController

					"sample/second": =>
						new SecondController

	return SampleModule