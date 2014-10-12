path    = require "path"
gulp    = require "gulp"
gutil   = require "gulp-util"
less    = require "gulp-less"
connect = require "gulp-connect"

lessIncludePaths = require "../less_includes.json"
outputDest       = path.join gutil.env.prefix, "styles"

gulp.task "styles", ->
  gulp.src("#{gutil.env.projectdir}/styles/index.less")
    .pipe(less paths: lessIncludePaths)
    .pipe(gulp.dest outputDest)
    .pipe(connect.reload())
