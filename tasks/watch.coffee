gulp       = require "gulp"
gutil      = require "gulp-util"
livereload = require "gulp-livereload"
{basename} = require "path"

gulp.task "watch", ["metalsmith", "browserify", "styles"], ->
  reportChange = ({type, path}) ->
    gutil.log "#{type} #{gutil.colors.cyan basename(path)}"

  livereload.listen(auto: true)

  gulp.watch(["./src/**/*", "./templates/**/*"], ["metalsmith"])
    .on("change", reportChange)

  gulp.watch("./lib/**/*", ["browserify"])
    .on("change", reportChange)

  gulp.watch("./scss/**/*", ["styles"])
    .on("change", reportChange)
