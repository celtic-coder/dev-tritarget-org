gulp       = require "gulp"
gutil      = require "gulp-util"
connect    = require "gulp-connect"
{basename} = require "path"

gulp.task "watch", ["metalsmith", "contact-data", "browserify", "styles"], ->
  reportChange = ({type, path}) ->
    gutil.log "#{type} #{gutil.colors.cyan basename(path)}"

  connect.server
    root:       gutil.env.prefix
    port:       8000
    livereload: true

  gulp.watch(["./src/**/*", "./templates/**/*"], ["metalsmith"])
    .on("change", reportChange)

  gulp.watch("./lib/**/*", ["browserify"])
    .on("change", reportChange)

  gulp.watch("./styles/**/*", ["styles"])
    .on("change", reportChange)

  gulp.watch("./info.json", ["contact-data"])
    .on("change", reportChange)

gulp.task "server", ["watch"]
