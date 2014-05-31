# # Show Views
#
# Defines all the views used on the "show" action of the `Muppets` module.
@App.module "MuppetsModule.Show", (Show, App, Backbone, Marionette, $, _) ->

  # ## MuppetView
  #
  # View to display the info about the `Muppet` to be shown.
  class Show.MuppetView extends App.Views.ItemView
    className: "muppet-view"
    template: "muppets/show/muppet-view"
