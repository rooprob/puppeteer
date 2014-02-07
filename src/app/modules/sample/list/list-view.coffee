@App.module "SampleModule.List", (List, App, Backbone, Marionette, $, _) ->

  class List.SampleView extends App.Views.ItemView
    template: App.templates["sample-list-sample-view"]
