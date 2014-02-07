@App.module "SampleModule.Trololo", (Trololo, App, Backbone, Marionette, $, _) ->

  class Trololo.TrololoView extends App.Views.ItemView
    template: App.templates["sample-trololo-sample-view"]
