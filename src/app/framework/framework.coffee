define [
	'framework/application'
	'framework/model'
	'framework/collection'
	'framework/controller'
	'framework/views/collectionview'
	'framework/views/compositeview'
	'framework/views/itemview'
	'framework/views/layout'
	'framework/router'
	'framework/module'
	'framework/views/view'
], (
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