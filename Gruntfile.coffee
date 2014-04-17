module.exports = (grunt) ->
  grunt.initConfig
    pkg: '<json:package.json>'

    # watch for changes in files
    watch:
      files: ['Gruntfile.coffee', 'js/*', 'js/lib/**/*', 'css/*', 'css/lib/**/*']
      tasks: 'onwatch'

    # compile coffee files
    # https://github.com/gruntjs/grunt-contrib-coffee
    coffee:
      lib:
        files:
          'js/bin/scripts.js': 'js/*.coffee'

    # compile sass files
    # https://github.com/gruntjs/grunt-contrib-sass
    sass:
      dist:
        options:
          quiet: true
          style: 'expanded'
        files:
          'css/bin/styles.css': 'css/styles.scss'

    # concat javascript
    # https://github.com/gruntjs/grunt-contrib-uglify
    uglify:
      options:
        mangle: false
        # beautify: true
        # compress: false
      my_target:
        files: require('./js/scripts.json')

  #add event to listen for file changes
  grunt.event.on "watch", (action, filepath, target) ->
    grunt.log.writeln "#{filepath} has #{action}"

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  # grunt.loadNpmTasks 'grunt-devtools'

  grunt.registerTask 'default', ['watch']
  grunt.registerTask 'onwatch', ['coffee', 'sass', 'uglify']
