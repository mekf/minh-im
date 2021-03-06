module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')

		coffee:
			dist:
				files: 
					# './app.js': './app.coffee'

		watch:
			js:
				files: ['./app.coffee']
				tasks: ['coffee']

	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-watch')

	grunt.registerTask 'default', ['coffee']