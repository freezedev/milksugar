module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json'),
    coffee:
      compile:
        options:
          sourceMap: true
        files:
          'dist/<%= pkg.name %>.js': ['src/**/*.coffee']
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
  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-dependo'
  
  grunt.registerTask 'doc', 'Generated documentation', ['dependo']
  grunt.registerTask 'default', 'Default task', ['coffee', 'uglify', 'doc']