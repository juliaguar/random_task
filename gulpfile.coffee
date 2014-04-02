gulp = require('gulp')

coffee = require('gulp-coffee')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
minify_css = require('gulp-minify-css')

paths =
	scripts: 'coffee/*.coffee'
	styles: 'styles/*.css'

gulp.task('scripts', 
	() ->
		gulp.src(paths.scripts)
			.pipe(coffee())
			.pipe(uglify())
			.pipe(concat('index.min.js'))
			.pipe(gulp.dest('static/build/js'))
)

gulp.task('styles',
	() ->
		gulp.src(paths.styles)
			.pipe(minify_css())
			.pipe(gulp.dest('static/build/css'))
)

gulp.task('watch',
	() ->
		gulp.watch(paths.scripts, ['scripts'])
		gulp.watch(paths.styles, ['styles'])
)

gulp.task('default', ['scripts', 'styles', 'watch'])