define ['marionette', 'framework/views/view'], (Marionette) ->

	# HELPERS
	# --------------------------------------------------------------------------------------
	createViewWithAnimationOptions = (options) ->
		view = new Marionette.View
		view.animations = options

		return view

	# BEFORE AND AFTER
	# --------------------------------------------------------------------------------------
	beforeEach ->
		@sandbox = sinon.sandbox.create()

	afterEach ->
		@sandbox.restore()

	# SPECS
	# --------------------------------------------------------------------------------------
	describe "Framework.View", ->

		# Animations
		# ------------------------------------------------------------------------------------
		describe "Animations", ->
			it "should hide view before render if 'render' animation equals to 'fadeIn'", ->
				view = createViewWithAnimationOptions render: 'fadeIn'
				spy = @sandbox.spy view.$el, 'hide'

				view.trigger('before:render')

				spy.should.have.been.called

			it "should fade view in on render if 'render' animation equals to 'fadeIn'", ->
				view = createViewWithAnimationOptions render: 'fadeIn'
				spy = @sandbox.spy view.$el, 'fadeIn'

				view.trigger('render')

				spy.should.have.been.called

			it "should fade view out before close 'close' animation equals to 'fadeOut'", ->
				view = createViewWithAnimationOptions close: 'fadeOut'
				spy = @sandbox.spy view.$el, 'fadeOut'

				view.trigger('before:close')

				spy.should.have.been.called