@App.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

_.extend Marionette.Renderer,

	lookups: ["modules/"]

	render: (template, data) ->
		return if template is false
		path = @getTemplate(template)

		unless path
			error = "Template '#{template}' not found!"
			console.error error
			throw new Error(error)
			return
		path(data)

	getTemplate: (template) ->
		for lookup in @lookups
			for path in [template, @withTemplate(template)]
				return App.templates[lookup + path] if App.templates[lookup + path]

	withTemplate: (string) ->
		array = string.split("/")
		array.splice(-1, 0, "templates")
		array.join("/")
