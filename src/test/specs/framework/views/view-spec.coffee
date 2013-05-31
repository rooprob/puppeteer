define ['marionette', 'framework/config/marionette/view'], (Marionette) ->

	describe "Framework.View", ->

		# HELPERS
		# ------------------------------------------------------------------------------------
		createViewWithAnimationOptions = (options) ->
			view = new Marionette.View
			view.animations = options

			return view

		spyShouldHaveBeenCalled = (spy, done) ->
			async = ->
				spy.should.have.been.called
				done()

			setTimeout async, 1

		shouldHideViewIfRenderAnimationIs = (animation, test) =>
			view = createViewWithAnimationOptions render: animation
			spy = test.sandbox.spy view.$el, 'hide'

			view.trigger('before:render')

			spy.should.have.been.called

		# BEFORE AND AFTER
		# ------------------------------------------------------------------------------------
		beforeEach ->
			@sandbox = sinon.sandbox.create()
			@should = require('chai').should()

		afterEach ->
			@sandbox.restore()

		# SPECS
		# ------------------------------------------------------------------------------------

		# Animations
		# ------------------------------------------------------------------------------------
		describe "Animations", ->

			# getAnimationFor()
			# ----------------------------------------------------------------------------------
			describe "getAnimationFor()", ->

				it "should get animation name for given action", ->
					view = createViewWithAnimationOptions render: 'fadeIn', close: 'fadeOut'

					view.getAnimationFor('render').should.equal 'fadeIn'
					view.getAnimationFor('close').should.equal 'fadeOut'

				it "should return null if no animation is defined for given action", ->
					view = createViewWithAnimationOptions render: 'fadeIn'

					@should.not.exist view.getAnimationFor('close')

			# before:render
			# ----------------------------------------------------------------------------------
			describe "before:render", ->

				it "should hide view before rendering if 'render' animation is 'fadeIn'", ->
					shouldHideViewIfRenderAnimationIs 'fadeIn', @

				it "should hide view before rendering if 'render' animation is 'slideDown'", ->
					shouldHideViewIfRenderAnimationIs 'slideDown', @

				it "should hide view before rendering if 'render' animation is 'show'", ->
					shouldHideViewIfRenderAnimationIs 'show', @

			# render
			# ----------------------------------------------------------------------------------
			describe "render", ->

				it "should fade view in on render if 'render' animation is 'fadeIn'", (done) ->
					view = createViewWithAnimationOptions render: 'fadeIn'
					spy = @sandbox.spy view.$el, 'fadeIn'

					view.trigger 'render'

					spyShouldHaveBeenCalled spy, done

			# before:close
			# ----------------------------------------------------------------------------------
			describe "before:close", ->

				it "should fade view out before close 'close' animation is 'fadeOut'", (done) ->
					view = createViewWithAnimationOptions close: 'fadeOut'
					spy = @sandbox.spy view.$el, 'fadeOut'

					view.trigger 'before:close'

					spyShouldHaveBeenCalled spy, done