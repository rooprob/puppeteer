module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		pkg: grunt.file.readJSON "package.json"

		paths:
			srcFolder: "./src"
			appFolder: "<%= paths.srcFolder %>/app"
			imagesFolder: "<%= paths.srcFolder %>/images"
			stylesFolder: "<%= paths.srcFolder%>/styles"
			distFolder: "./dist"
			testsFolder: "./test"

		snocketsify:
			app:
				src: "<%= paths.srcFolder %>/javascript.coffee"
				dest: "<%= paths.distFolder %>/app.js"
			test:
				src: "<%= paths.testsFolder %>/unit/test.coffee"
				dest: "<%= paths.testsFolder %>/unit/test.js"

		uglify:
			production:
				files:
					"<%= paths.distFolder %>/app.min.js" : "<%= paths.distFolder %>/app.js"

		clean:
			dist: "<%= paths.distFolder %>"
			images: "<%= paths.distFolder %>/images"

		imagemin:
			compile:
				options:
					cache: false
				files: [{
					expand: true
					cwd: "<%= paths.imagesFolder %>"
					src: ["**/*.{png,jpg,gif}"]
					dest: "<%= paths.distFolder %>/images"
				}]

		copy:
			html_dev:
				src: "<%= paths.srcFolder %>/index.html"
				dest: "<%= paths.distFolder %>/index.html"
			html_production:
				src: "<%= paths.srcFolder %>/index.html"
				dest: "<%= paths.distFolder %>/index.html"
				options:
					process: (content, path) ->
						content = content.replace ".js", ".min.js"
						content = content.replace ".css", ".min.css"
						content = content.replace "environment: \"dev\"", "environment: \"production\""
						return content

		concat:
			compile:
				src: ["<%= paths.distFolder %>/app.js", "<%= paths.appFolder %>/templates/templates.js"]
				dest: "<%= paths.distFolder %>/app.js",

		handlebars:
			compile:
				options:
					namespace: "App.templates"
					processName: (path) ->
						path = path.replace "./src/app/", ""
						path = path.replace ".hbs", ""
						return path
				files:
					"<%= paths.appFolder %>/templates/templates.js" : "<%= paths.appFolder %>/**/*.hbs"

		autoprefixer:
			options:
				browsers: ["last 1 version", "> 1%", "ie 8", "ie 7"]
			dev:
				src: "<%= paths.distFolder %>/app.css"
				dest: "<%= paths.distFolder %>/app.css"
			production:
				src: "<%= paths.distFolder %>/app.min.css"
				dest: "<%= paths.distFolder %>/app.min.css"

		sass:
			dev:
				options:
					style: "expanded"
				files:
					"<%= paths.distFolder %>/app.css": "<%= paths.stylesFolder %>/app.scss"
			production:
				options:
					style: "compressed"
				files:
					"<%= paths.distFolder %>/app.min.css": "<%= paths.stylesFolder %>/app.scss"

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
				files: ["<%= paths.srcFolder %>/**/*.coffee", "<%= paths.srcFolder %>/**/*.hbs"]
				tasks: ["app:dev"]
				options:
					livereload: true
			styles:
				files: ["<%= paths.stylesFolder %>/**/*.scss"]
				tasks: ["styles:dev"]
				options:
					livereload: true
			html:
				files: ["<%= paths.srcFolder %>/index.html"]
				tasks: ["copy:html_dev"]
				options:
					livereload: true
			images:
				files: ["<%= paths.imagesFolder %>/**/*"]
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
	grunt.registerTask "app:production", ["snocketsify:app", "templates", "uglify:production"]
	grunt.registerTask "styles", ["sass", "autoprefixer"]
	grunt.registerTask "styles:dev", ["sass:dev", "autoprefixer:dev"]
	grunt.registerTask "templates", ["handlebars", "concat"]

	grunt.registerTask "dev", ["clean:dist", "app:dev", "app:test", "copy:html_dev", "images", "styles:dev"]
	grunt.registerTask "production", ["connect", "clean:dist", "app:production", "copy:html_production", "images", "styles", "casperjs", "mocha"]
	grunt.registerTask "default", ["dev", "connect", "watch"]
