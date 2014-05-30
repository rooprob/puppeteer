# # Show Controller
#
# This controller will handle everything related to the "show"
# action of the `Muppet` module. Extends from `App.Controllers.Application`,
# which in the end is nothing but a custom extension of `Marionette.Controller`.
@App.module "MuppetsModule.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    # ## Initialize
    #
    # Shows a `Show.MuppetView` on the Application default region
    # for the `Muppet` to be shown.
    initialize: (muppet) ->
      muppetView = @getMuppetView muppet
      @show muppetView

    # ## getMuppetView
    #
    # Returns a new instance of a `Show.MuppetView` passing the
    # `Muppet` to be shown.
    getMuppetView: (muppet) ->
      new Show.MuppetView
        model: muppet
