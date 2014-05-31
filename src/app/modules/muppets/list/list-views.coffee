# # List Views
#
# Defines all the views used on the "list" action of the
# `Muppets` module.
@App.module "MuppetsModule.List", (List, App, Backbone, Marionette, $, _) ->

  # ## Layout
  #
  # Defines two regions for this module:
  #
  # * `filterRegion`: will hold the filter component
  # * `contentRegion`: will hold the `Muppets` list
  class List.Layout extends App.Views.Layout
    template: "muppets/list/layout"
    regions:
      filterRegion: "#filter"
      contentRegion: "#content"

  # ## ItemView
  #
  # Each `Muppet` on the list.
  #
  # Triggers a `muppet:clicked` event when
  # is clicked.
  class List.ItemView extends App.Views.ItemView
    tagName: "li"
    className: "muppets-item"
    template: "muppets/list/muppet-item"
    triggers:
      "a click": "muppet:clicked"

  # ## ListView
  #
  # List of `Muppets`. Shows a `ItemView` for every
  # `Muppet` on the list
  class List.ListView extends App.Views.CompositeView
    className: "muppets-list"
    template: "muppets/list/muppets-list"
    itemView: List.ItemView
    itemViewContainer: "ul"
