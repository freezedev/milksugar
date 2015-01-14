module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    amd_tamer:
      all:
        files:
          'dist/<%= pkg.name %>.coffee': ['src/**/*.coffee']
    coffee:
      compile:
        options:
          sourceMap: true
        files:
          'dist/<%= pkg.name %>.js': 'dist/<%= pkg.name %>.coffee'
    uglify:
      options:
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("dd-mm-yyyy") %> */\n'
        report: 'gzip'
      dist:
        files:
          'dist/<%= pkg.name %>.min.js': ['dist/milksugar.js']
    dependo:
      targetPath: 'src'
      outputPath: './doc/dependencies'
      format: 'amd'
    coffeelint:
      all: ['src/**/*.coffee']
    codo:
      src: ['src']
      options:
        output: 'doc/api'
        title: 'MilkSugar API Documentation'
  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-dependo'
  grunt.loadNpmTasks 'grunt-coffeelint'
  
  grunt.registerTask 'doc', 'Generated documentation', ['codo', 'dependo']
  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'codo', ->
    done = @async()
    
    codo = require 'codo'
    
    codo.run -> done()
  grunt.registerTask 'default', 'Default task', ['coffee', 'uglify', 'doc']
