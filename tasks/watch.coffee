gulp       = require "gulp"
gutil      = require "gulp-util"
connect    = require "gulp-connect"
{basename} = require "path"

gulp.task "watch", ["metalsmith", "browserify", "styles"], ->
  reportChange = ({type, path}) ->
    gutil.log "#{type} #{gutil.colors.cyan basename(path)}"

  connect.server
    root:       gutil.env.prefix
    port:       8000
    fallback:   "index.html"
    livereload: true

  gulp.watch(["./src/**/*", "./templates/**/*"], ["metalsmith"])
    .on("change", reportChange)

  gulp.watch("./lib/**/*", ["browserify"])
    .on("change", reportChange)

  gulp.watch("./scss/**/*", ["styles"])
    .on("change", reportChange)

gulp.task "server", ["watch"]
