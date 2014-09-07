gulp = require "gulp"
gutil = require "gulp-util"
rimraf = require "gulp-rimraf"

gulp.task "clean", ->
  gulp.src(gutil.env.prefix, read: false)
  .pipe(rimraf())
