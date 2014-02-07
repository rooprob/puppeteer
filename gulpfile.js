var gulp		= require("gulp");
var plugins	= require("gulp-load-plugins")();
var color		= plugins.util.colors;
var lr;

// ----------------------------------------------------------------------------
// Tasks config
// ----------------------------------------------------------------------------
var config = {
	serverPort: 3000,
	livereloadPort : 35729,
	paths: {
		tmp: "./tmp/",
		dist: "./dist/",
		test: "./test/",
		distImages: "./dist/images/",
		index: "./src/index.html",
		images: "./src/images/**/*",
		appStyleFile: "./src/styles/app.scss",
		appScriptFile: "./src/javascript.coffee",
		testScriptFile: "./test/test.coffee",
		styles: "./src/styles/**/*",
		scripts: "./src/**/*.coffee",
		tests: "./test/**/*",
		hbs: "./src/app/**/*.hbs"
	}
};

// ----------------------------------------------------------------------------
// Tasks
// ----------------------------------------------------------------------------
gulp.task("clean", function() {
	gulp.src(config.paths.dist, { read: false })
		.pipe(plugins.rimraf());
});

gulp.task("server", function() {
	var express = require("express");
	var app = express();

	plugins.util.log("Starting", color.cyan("HTTP Server"), "on:", color.magenta("http://localhost:3000/"));
	app.use(require("connect-livereload")());
	app.use(express.static(__dirname));
	app.listen(config.serverPort);

	plugins.util.log("Starting", color.cyan("LiveReload"));
	lr = require("tiny-lr")();
	lr.listen(config.livereloadPort);
});

gulp.task("html", function() {
	gulp.src(config.paths.index)
		.pipe(gulp.dest(config.paths.dist))
		.pipe(plugins.if(lr, plugins.livereload(lr)));
});

gulp.task("images", function() {
	gulp.src(config.paths.images)
		.pipe(plugins.cache(plugins.imagemin({
			optimizationLevel: 5,
			progressive: true,
			interlaced: true
		})))
		.pipe(gulp.dest(config.paths.distImages))
		.pipe(plugins.if(lr, plugins.livereload(lr)));
});

gulp.task("styles", function() {
	gulp.src(config.paths.appStyleFile)
		.pipe(plugins.rubySass({
			style: "compressed"
		}))
		.pipe(plugins.autoprefixer("last 1 version", "> 1%", "ie 8", "ie 7"))
		.pipe(plugins.minifyCss())
		.pipe(gulp.dest(config.paths.dist))
		.pipe(plugins.if(lr, plugins.livereload(lr)));
});

gulp.task("templates", function(){
	return gulp.src(config.paths.hbs)
		.pipe(plugins.handlebars({
			wrapped: true
		}))
		.pipe(plugins.declare({
			namespace: "App.templates"
		}))
		.pipe(plugins.concat("templates.js"))
		.pipe(gulp.dest('./src/app/templates/'));
});

gulp.task("app", ["templates"], function() {
	return gulp.src(config.paths.appScriptFile)
		.pipe(plugins.include({
			extensions: "coffee"
		}))
		.pipe(plugins.coffeelint())
		.pipe(plugins.coffeelint.reporter())
		.pipe(plugins.coffee())
		.pipe(plugins.include({
			extensions: "js"
		}))
		.pipe(plugins.rename("app.js"))
		.pipe(gulp.dest(config.paths.dist))
		.pipe(plugins.if(lr, plugins.livereload(lr)));
});

gulp.task("test", ["app"], function() {
	return gulp.src(config.paths.testScriptFile)
		.pipe(plugins.include({
			extensions: "coffee"
		}))
		.pipe(plugins.coffeelint())
		.pipe(plugins.coffeelint.reporter())
		.pipe(plugins.coffee())
		.pipe(plugins.include({
			extensions: "js"
		}))
		.pipe(gulp.dest(config.paths.test))
		.pipe(plugins.if(lr, plugins.livereload(lr)));
});

gulp.task("watch", function() {
	gulp.watch(config.paths.index, ["html"]);
	gulp.watch(config.paths.images, ["images"]);
	gulp.watch(config.paths.styles, ["styles"]);
	gulp.watch([config.paths.scripts, config.paths.hbs, config.paths.tests], ["test"]);
});

// ----------------------------------------------------------------------------
// Public tasks
// ----------------------------------------------------------------------------
gulp.task("compile", ["html", "images", "styles", "test"]);
gulp.task("dev", ["server", "compile", "watch"]);
