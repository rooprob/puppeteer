define [
	'framework/controller'
	'marionette'
	'communication-bus'
], (Controller, Marionette, CommunicationBus) ->

	# BEFORE AND AFTER
	# --------------------------------------------------------------------------------------
	beforeEach ->
		@sandbox = sinon.sandbox.create()
		@region = new Marionette.Region
			el: '#sandbox'

		@view = new Marionette.ItemView
			template: '<div>test</div>'

		@controller = new Controller
			region: @region

	afterEach ->
		@region = null
		@controller = null
		@sandbox.restore()

	# SPECS
	# --------------------------------------------------------------------------------------
	describe "Framework.Controller", ->

		# Global
		# ------------------------------------------------------------------------------------
		describe "Global", ->
			it "should be an instance of Marionette.Controller", ->
				@controller.should.be.an.instanceof Marionette.Controller

		# Regions
		# ------------------------------------------------------------------------------------
		describe "Regions", ->
			it "should set region attribute on the Controller", ->
				@controller.region.should.equal @region

			it "should use default region if no region is given", ->
				stub = @sandbox.stub CommunicationBus.reqres, "request", (value) ->
					console.log "Stub called with: #{value}"

				controller = new Controller

				stub.should.have.been.calledWith "app:default:region"

		# show()
		# ------------------------------------------------------------------------------------
		describe "show()", ->
			it "should show given view on the Controller's region", ->
				stub = @sandbox.stub @region, "show", (args...) ->
					console.log "Stub called with:", args

				@controller.show @view

				stub.should.have.been.calledWith @view

			it "should bind to View's close event and close the controller", ->
				stub = @sandbox.stub @controller, "close", (args...) ->
					console.log "Stub called with:", args

				@controller.show @view
				@view.trigger('close')

				stub.should.have.been.called