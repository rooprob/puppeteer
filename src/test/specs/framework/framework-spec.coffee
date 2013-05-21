define [
	'marionette'
	'app.framework'
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
], (
	Marionette,
	Framework,
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

	describe "Framework", ->

		it "should have a property Application being an instance of Application", ->
			prop = new Framework.Application
			prop.should.be.an.instanceof Application

		it "should have a property Model being an instance of Model", ->
			prop = new Framework.Model
			prop.should.be.an.instanceof Model

		it "should have a property Collection being an instance of Collection", ->
			prop = new Framework.Collection
			prop.should.be.an.instanceof Collection

		it "should have a property Controller being an instance of Controller", ->
			region = new Marionette.Region
				el: '#sandbox'

			prop = new Framework.Controller
				region: region

			prop.should.be.an.instanceof Controller

		it "should have a property CollectionView being an instance of CollectionView", ->
			prop = new Framework.CollectionView
			prop.should.be.an.instanceof CollectionView

		it "should have a property CompositeView being an instance of CompositeView", ->
			prop = new Framework.CompositeView
			prop.should.be.an.instanceof CompositeView

		it "should have a property ItemView being an instance of ItemView", ->
			prop = new Framework.ItemView
			prop.should.be.an.instanceof ItemView

		it "should have a property Layout being an instance of Layout", ->
			prop = new Framework.Layout
			prop.should.be.an.instanceof Layout

		it "should have a property AppRouter being an instance of AppRouter", ->
			prop = new Framework.AppRouter
			prop.should.be.an.instanceof AppRouter