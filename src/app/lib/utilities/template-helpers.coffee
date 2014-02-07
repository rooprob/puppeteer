@App.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

	Handlebars.registerHelper "linkTo", (name, url, options = {}) ->
		options = options.hash

		_.defaults options,
			external: false

		url = "#" + url unless options.external

		return new Handlebars.SafeString("<a href='#{url}'>#{name}</a>")
