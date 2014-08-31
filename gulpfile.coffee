#jslint node: true

gulp = require 'gulp'
sass = require 'gulp-sass'
browserSync = require 'browser-sync'
bourbon = require('node-bourbon').includePaths
source = require 'vinyl-source-stream'
gutil = require 'gulp-util'
uglify = require 'gulp-uglify'
task = gutil.env._[0]
notify = require("gulp-notify")
coffee = require('gulp-coffee')

#Styles
gulp.task 'styles', ->
	gulp.src 'app/scss/**/*.scss'
		.pipe sass
			outputStyle: if task is 'build' then 'compressed' else 'expanded'
			includePaths : [bourbon]
			errLogToConsole: false
			onError: (err) -> notify().write err
		.pipe gulp.dest 'app/build/css/'
		.pipe browserSync.reload stream:true

#Scripts

gulp.task 'scripts', ->
	gulp.src 'app/js/src/*.coffee'
		.pipe coffee
			bare: true
		.on 'error', reportError
		.pipe gulp.dest 'app/build/js/'

reportError = (errors...) ->

	console.log errors

	notify.onError
		title: "Compile Error"
		message: "<%= error.message %>"
	.apply(this, errors)

	this.emit 'end'


#Browser sync
gulp.task 'browser-sync', ->
	browserSync.init null,
		server:
			baseDir: './app'


#Reload all Browsers
gulp.task 'bs-reload', -> browserSync.reload()

#Watch files
gulp.task 'watch', ['styles','scripts', 'browser-sync'], ->
	gulp.watch 'app/*.html', ['bs-reload']
	gulp.watch 'app/scss/**/*.scss', ['styles']
	gulp.watch 'app/js/src/**/*.js',['scripts']
	gulp.watch 'app/js/src/**/*.coffee',['scripts']

gulp.task 'build',['styles','scripts']



