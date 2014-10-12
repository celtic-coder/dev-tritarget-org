path    = require "path"
gulp    = require "gulp"
gutil   = require "gulp-util"
less    = require "gulp-less"
connect = require "gulp-connect"

lessConfig  = require "../less_config.json"
styleOutput = path.join gutil.env.prefix, "styles"
fontsOutput = path.join gutil.env.prefix, "fonts"

gulp.task "styles", ["less", "fonts"]

gulp.task "less", ->
  gulp.src("#{gutil.env.projectdir}/styles/index.less")
    .pipe(less paths: lessConfig.includes)
    .pipe(gulp.dest styleOutput)
    .pipe(connect.reload())

gulp.task "fonts", ->
  gulp.src(lessConfig.fonts)
    .pipe(gulp.dest fontsOutput)
