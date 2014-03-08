module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		pkg: grunt.file.readJSON "package.json"

		paths:
			src:
				rootFolder: "./src"
				appFolder: "<%= paths.src.rootFolder %>/app"
				imagesFolder: "<%= paths.src.rootFolder %>/images"
				stylesFolder: "<%= paths.src.rootFolder%>/styles"
			dist:
				rootFolder: "./dist"
				appFolder: "<%= paths.dist.rootFolder %>/app"
				imagesFolder: "<%= paths.dist.rootFolder %>/images"
				stylesFolder: "<%= paths.dist.rootFolder%>/styles"

			testsFolder: "./test"

		snocketsify:
			app:
				src: "<%= paths.src.rootFolder %>/javascript.coffee"
				dest: "<%= paths.dist.rootFolder %>/app.js"
			test:
				src: "<%= paths.testsFolder %>/unit/test.coffee"
				dest: "<%= paths.testsFolder %>/unit/test.js"

		uglify:
			production:
				files:
					"<%= paths.dist.rootFolder %>/app.min.js" : "<%= paths.dist.rootFolder %>/app.js"

		clean:
			dist: "<%= paths.dist.rootFolder %>"
			images: "<%= paths.dist.imagesFolder %>"

		imagemin:
			compile:
				options:
					cache: false
				files: [
					expand: true
					cwd: "<%= paths.src.imagesFolder %>"
					src: ["**/*.{png,jpg,gif}"]
					dest: "<%= paths.dist.imagesFolder %>"
				]

		copy:
			html_dev:
				src: "<%= paths.src.rootFolder %>/index.html"
				dest: "<%= paths.dist.rootFolder %>/index.html"
			html_production:
				src: "<%= paths.src.rootFolder %>/index.html"
				dest: "<%= paths.dist.rootFolder %>/index.html"
				options:
					process: (content, path) ->
						content = content.replace ".js", ".min.js"
						content = content.replace ".css", ".min.css"
						content = content.replace "environment: \"dev\"", "environment: \"production\""
						return content

		concat:
			compile:
				src: ["<%= paths.dist.rootFolder %>/app.js", "<%= paths.src.appFolder %>/templates/templates.js"]
				dest: "<%= paths.dist.rootFolder %>/app.js",

		handlebars:
			compile:
				options:
					namespace: "App.templates"
					processName: (path) ->
						path = path.replace "./src/app/", ""
						path = path.replace ".hbs", ""
						return path
				files:
					"<%= paths.src.appFolder %>/templates/templates.js" : "<%= paths.src.appFolder %>/**/*.hbs"

		autoprefixer:
			options:
				browsers: ["last 1 version", "> 1%", "ie 8", "ie 7"]
			
			dev:
				src: "<%= paths.dist.rootFolder %>/app.css"
				dest: "<%= paths.dist.rootFolder %>/app.css"

			production:
				src: "<%= paths.dist.rootFolder %>/app.css"
				dest: "<%= paths.dist.rootFolder %>/app.min.css"

		compass:
			dev:
				options:
					cssDir:	"<%= paths.dist.rootFolder %>"
					sassDir: "<%= paths.src.stylesFolder %>"
					imagesDir: "<%= paths.dist.imagesFolder %>"
					generatedImagesDir: "<%= paths.dist.imagesFolder %>"
					environment: "development"
					outputStyle: "expanded"
					relativeAssets: true

			production:
				options:
					cssDir:	"<%= paths.dist.rootFolder %>"
					sassDir: "<%= paths.src.stylesFolder %>"
					imagesDir: "<%= paths.dist.imagesFolder %>"
					generatedImagesDir: "<%= paths.dist.imagesFolder %>"
					environment: "production"
					outputStyle: "compressed"
					relativeAssets: true

		connect:
			server:
				options:
					port: 3000
					livereload: true

		casperjs:
			files: ["<%= paths.testsFolder %>/integration/**/*.coffee"]

		mocha:
			test:
				options:
					run: true
					urls: ["http://localhost:3000/test/unit/"]

		watch:
			app:
				files: ["<%= paths.src.rootFolder %>/**/*.coffee", "<%= paths.src.rootFolder %>/**/*.hbs"]
				tasks: ["app:dev"]
				options:
					livereload: true
			styles:
				files: ["<%= paths.src.stylesFolder %>/**/*.scss"]
				tasks: ["styles:dev"]
				options:
					livereload: true
			html:
				files: ["<%= paths.src.rootFolder %>/index.html"]
				tasks: ["copy:html_dev"]
				options:
					livereload: true
			images:
				files: ["<%= paths.src.imagesFolder %>/**/*"]
				tasks: ["images"]
				options:
					livereload: true
			integration_tests:
				files: ["<%= paths.testsFolder %>/integration/**/*.coffee"]
				tasks: ["casperjs"]
			unit_tests:
				files: ["<%= paths.testsFolder %>/unit/specs/**/*.coffee"]
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
