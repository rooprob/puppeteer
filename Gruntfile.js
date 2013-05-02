module.exports = function(grunt) {

  /* =DEPENDENCIES
  --------------------------------------------------------------------------- */
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-requirejs');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-mocha');

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
          './dev/app/assets/css/main.css': './src/app/assets/css/main.less'
        }
      },
      production: {
        options: {
          yuicompress: true
        },
        files: {
          './production/app/assets/css/main.css': './src/app/assets/css/main.less'
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
    'less:dev'
  ]);

  grunt.registerTask('production', [
    'clean:production',
    'coffee',
    'less:production',
    'requirejs'
  ]);

  grunt.registerTask('test', [
    'coffee',
    'connect:test',
    'mocha'
  ]);

};