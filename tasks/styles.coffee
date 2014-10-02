gulp    = require "gulp"
gutil   = require "gulp-util"
less    = require "gulp-less"
connect = require "gulp-connect"

lessIncludePaths = [
  "./bower_components/bootstrap/less"
  "./bower_components/highlightjs/styles"
]

gulp.task "styles", ->
  gulp.src("#{gutil.env.projectdir}/styles/index.less")
    .pipe(less paths: lessIncludePaths)
    .pipe(gulp.dest gutil.env.prefix)
    .pipe(connect.reload())
