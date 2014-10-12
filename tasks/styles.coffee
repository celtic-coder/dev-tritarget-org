path    = require "path"
gulp    = require "gulp"
gutil   = require "gulp-util"
gulpif  = require "gulp-if"
less    = require "gulp-less"
minify  = require "gulp-minify-css"
connect = require "gulp-connect"

lessConfig  = require "../less_config.json"
styleOutput = path.join gutil.env.prefix, "styles"
fontsOutput = path.join gutil.env.prefix, "fonts"

gulp.task "styles", ["less", "fonts"]

gulp.task "less", ->
  gulp.src("#{gutil.env.projectdir}/styles/index.less")
    .pipe(less paths: lessConfig.includes)
    .pipe(gulpif gutil.env.prod, minify())
    .pipe(gulp.dest styleOutput)
    .pipe(connect.reload())

gulp.task "fonts", ->
  gulp.src(lessConfig.fonts)
    .pipe(gulp.dest fontsOutput)
