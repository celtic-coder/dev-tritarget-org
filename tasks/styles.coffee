gulp           = require "gulp"
gutil          = require "gulp-util"
sass           = require "gulp-sass"
livereload     = require "gulp-livereload"
{includePaths} = require "node-bourbon"

gulp.task "styles", ->
  gulp.src("#{gutil.env.projectdir}/scss/index.scss")
    .pipe(sass {includePaths})
    .pipe(gulp.dest gutil.env.prefix)
    .pipe(livereload auto: false)
