module.exports = function(grunt) {

	/* =DEPENDENCIES
	--------------------------------------------------------------------------- */
	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-connect');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-requirejs');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-mocha');
	grunt.loadNpmTasks('grunt-smushit');

	/* =CONFIG
	--------------------------------------------------------------------------- */
	grunt.initConfig({

		clean : {
			all : ['./dev/*', './production/*'],
			dev : ['./dev/*'],
			production : ['./production']
		},

		connect: {
			dev: {
				options : {
					port: 8000,
					base: '.',
					keepalive: true
				}
			},

			test: {
				options : {
					port: 8888,
					base: '.'
				}
			}
		},

		copy: {
			dev: {
				files: [
					{
						expand: true,
						cwd: './src/app/assets',
						src: ['**'],
						dest: './dev/app/assets'
					}
				]
			},

			production: {
				files: [
					{
						expand: true,
						cwd: './src/app/assets',
						src: ['**'],
						dest: './production/app/assets'
					}
				]
			}
		},

		smushit : {
			production: {
				src: './production/app/assets'
			}
		},

		requirejs: {
			compile: {
				options: {
					baseUrl: './dev/app',
					mainConfigFile: './dev/app/main.js',
					out: './production/app/main.js',
					include: 'main',
					uglify: {
						toplevel: true,
						ascii_only: true,
						beautify: false,
						max_line_length: 1000
					},
					preserveLicenseComments: false
				}
			}
		},

		coffee : {
			dev : {
				files : [
					{
						expand: true,
						cwd: './src/',
						src: ['**/*.coffee'],
						dest: './dev/',
						ext: '.js'
					}
				]
			}
		},

		less: {
			dev: {
				files: {
					'./dev/app/css/main.css': './src/app/css/main.less'
				}
			},
			production: {
				options: {
					yuicompress: true
				},
				files: {
					'./production/app/css/main.css': './src/app/css/main.less'
				}
			},
		},

		mocha: {
			test : {
				options: {
					urls: [ 'http://localhost:8888/test.html'],
					reporter : 'Spec'
				}
			}
		},

		watch: {
			coffee : {
				files: './src/app/**/*.coffee',
				tasks: ['coffee']
			},
			less: {
				files: './src/**/*.less',
				tasks: ['less:dev']
			},
			test: {
				files: './src/test/**/*.coffee',
				tasks: ['test']
			}
		}

	});

	/* =TASKS
	--------------------------------------------------------------------------- */
	grunt.registerTask('default', ['dev', 'connect:dev']);

	grunt.registerTask('dev', [
		'clean:dev',
		'coffee',
		'less:dev',
		'copy:dev'
	]);

	grunt.registerTask('production', [
		'clean:production',
		'test',
		'less:production',
		'requirejs',
		'copy:production',
		'smushit:production'
	]);

	grunt.registerTask('test', [
		'coffee',
		'connect:test',
		'mocha'
	]);

};