define ['marionette'], (Marionette) ->
  app = new Marionette.Application()

  app.on "initialize:after", (options) ->
    Backbone.history.start() if Backbone.history

  return app;