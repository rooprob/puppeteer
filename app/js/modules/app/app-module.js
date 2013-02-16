define(['marionette'], function(Marionette) {
  var app = new Marionette.Application();

  app.on("initialize:after", function(options){
    if (Backbone.history){
      Backbone.history.start();
    }
  });

  return app;
});