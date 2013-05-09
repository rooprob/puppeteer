define ['marionette'], (Marionette) ->

	# Overwrite default Marionette's "loadTemplate" method
	# to allow using text! templates with RequireJS
	Marionette.TemplateCache::loadTemplate = (templateId) ->
		template = templateId

		return template unless !template or template.length == 0

		err = new Error "Template not found: '#{templateId}'"
		err.name = "NoTemplateError"