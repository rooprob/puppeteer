# # Environment Utils
#
# Utils related to the environment of the application.
@App.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  # After the application has been initialized, a reference to
  # the environment is stored under `App.environment`.
  #
  # This environment is passed the `start()` of the application.
  # If no environment is passed, the default is "production"
  App.on "before:start", (options) ->
    App.environment = options.environment or "production"
