define [
	'underscore'
	'framework/application'
	'framework/entities/model'
	'framework/entities/collection'
	'framework/controller'
	'framework/views/collectionview'
	'framework/views/compositeview'
	'framework/views/itemview'
	'framework/views/layout'
	'framework/router'
	'framework/module'
	'framework/config/backbone/sync'
	'framework/config/marionette/view'
	'framework/config/marionette/template-cache'
], (
	_,
	Application,
	Model,
	Collection,
	Controller,
	CollectionView,
	CompositeView,
	ItemView,
	Layout,
	AppRouter,
	Module
) ->

	return {
		Application : Application
		Model : Model
		Collection : Collection
		Controller : Controller
		CollectionView : CollectionView
		CompositeView : CompositeView
		ItemView : ItemView
		Layout : Layout
		AppRouter : AppRouter
		Module : Module
	}