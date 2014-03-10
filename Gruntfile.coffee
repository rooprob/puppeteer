module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		pkg: grunt.file.readJSON "package.json"

		paths:
			src:
				root: "./src"
				app: "<%= paths.src.root %>/app"
				images: "<%= paths.src.root %>/images"
				styles: "<%= paths.src.root %>/styles"
			dist:
				root: "./dist"
				app: "<%= paths.dist.root %>/app"
				images: "<%= paths.dist.root %>/images"
				styles: "<%= paths.dist.root %>/styles"
			tests:
				root: "./test"
				unit: "<%= paths.tests.root %>/unit"
				functional: "<%= paths.tests.root %>/functional"

		snocketsify:
			app:
				src: "<%= paths.src.root %>/javascript.coffee"
				dest: "<%= paths.dist.root %>/app.js"
			test:
				src: "<%= paths.tests.unit %>/test.coffee"
				dest: "<%= paths.tests.unit %>/test.js"

		uglify:
			production:
				files:
					"<%= paths.dist.root %>/app.min.js" : "<%= paths.dist.root %>/app.js"

		clean:
			dist: "<%= paths.dist.root %>"
			images: "<%= paths.dist.images %>"

		imagemin:
			compile:
				options:
					cache: false
				files: [
					expand: true
					cwd: "<%= paths.src.images %>"
					src: ["**/*.{png,jpg,gif}"]
					dest: "<%= paths.dist.images %>"
				]

		copy:
			html_dev:
				src: "<%= paths.src.root %>/index.html"
				dest: "<%= paths.dist.root %>/index.html"
			html_production:
				src: "<%= paths.src.root %>/index.html"
				dest: "<%= paths.dist.root %>/index.html"
				options:
					process: (content, path) ->
						content = content.replace ".js", ".min.js"
						content = content.replace ".css", ".min.css"
						content = content.replace "environment: \"dev\"", "environment: \"production\""
						return content

		concat:
			compile:
				src: ["<%= paths.dist.root %>/app.js", "<%= paths.src.app %>/templates/templates.js"]
				dest: "<%= paths.dist.root %>/app.js",

		handlebars:
			compile:
				options:
					namespace: "App.templates"
					processName: (path) ->
						path = path.replace "./src/app/", ""
						path = path.replace ".hbs", ""
						return path
				files:
					"<%= paths.src.app %>/templates/templates.js" : "<%= paths.src.app %>/**/*.hbs"

		autoprefixer:
			options:
				browsers: ["last 1 version", "> 1%", "ie 8", "ie 7"]

			dev:
				src: "<%= paths.dist.root %>/app.css"
				dest: "<%= paths.dist.root %>/app.css"

			production:
				src: "<%= paths.dist.root %>/app.css"
				dest: "<%= paths.dist.root %>/app.min.css"

		compass:
			dev:
				options:
					cssDir:	"<%= paths.dist.root %>"
					sassDir: "<%= paths.src.styles %>"
					imagesDir: "<%= paths.dist.images %>"
					generatedImagesDir: "<%= paths.dist.images %>"
					environment: "development"
					outputStyle: "expanded"
					relativeAssets: true

			production:
				options:
					cssDir:	"<%= paths.dist.root %>"
					sassDir: "<%= paths.src.styles %>"
					imagesDir: "<%= paths.dist.images %>"
					generatedImagesDir: "<%= paths.dist.images %>"
					environment: "production"
					outputStyle: "compressed"
					relativeAssets: true

		connect:
			server:
				options:
					port: 3000
					livereload: true

		casperjs:
			files: ["<%= paths.tests.functional %>/**/*.coffee"]

		mocha:
			test:
				options:
					run: true
					urls: ["http://localhost:3000/test/unit/"]

		watch:
			app:
				files: ["<%= paths.src.root %>/**/*.coffee", "<%= paths.src.root %>/**/*.hbs"]
				tasks: ["app:dev"]
				options:
					livereload: true
			styles:
				files: ["<%= paths.src.styles %>/**/*.scss"]
				tasks: ["styles:dev"]
				options:
					livereload: true
			html:
				files: ["<%= paths.src.root %>/index.html"]
				tasks: ["copy:html_dev"]
				options:
					livereload: true
			images:
				files: ["<%= paths.src.images %>/**/*"]
				tasks: ["images"]
				options:
					livereload: true
			functional_tests:
				files: ["<%= paths.tests.functional %>/**/*.coffee"]
				tasks: ["casperjs"]
			unit_tests:
				files: ["<%= paths.tests.unit %>/specs/**/*.coffee"]
				tasks: ["app:dev", "app:test", "mocha"]
				options:
					livereload: true

	grunt.registerTask "images", ["clean:images", "imagemin"]
	grunt.registerTask "app:dev", ["snocketsify:app", "templates"]
	grunt.registerTask "app:test", ["snocketsify:test"]
	grunt.registerTask "app:production", ["snocketsify:app", "templates", "uglify:production" ]
	grunt.registerTask "styles", ["compass:production", "autoprefixer" ]
	grunt.registerTask "styles:dev", ["compass:dev", "autoprefixer:dev"]
	grunt.registerTask "templates", ["handlebars", "concat"]

	grunt.registerTask "dev", ["clean:dist", "app:dev", "app:test", "copy:html_dev", "images", "styles:dev"]
	grunt.registerTask "production", ["connect", "clean:dist", "app:production", "copy:html_production", "images", "styles", "casperjs", "mocha"]
	grunt.registerTask "default", ["dev", "connect", "watch"]
