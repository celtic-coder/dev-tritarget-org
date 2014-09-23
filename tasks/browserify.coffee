gulp       = require "gulp"
gutil      = require "gulp-util"
path       = require "path"
fs         = require "fs"
source     = require "vinyl-source-stream"
browserify = require "browserify"
gulpif     = require "gulp-if"
uglify     = require "gulp-uglify"
streamify  = require "gulp-streamify"
connect    = require "gulp-connect"
preamble   = require "./lib/preamble"

headerFile     = "preamble.ejs"
outputFileName = "index.js"

gulp.task "browserify", ->
  pkg          = require(path.join gutil.env.projectdir, "package.json")
  preamblePath = path.join gutil.env.projectdir, headerFile
  bundlePath   = path.join gutil.env.projectdir, "/lib/index.coffee"

  browserify(bundlePath, entry: true, debug: !gutil.env.prod)
    .bundle()
    .pipe(source outputFileName)
    .pipe(gulpif gutil.env.prod, streamify uglify())
    .pipe(preamble(preamblePath, {pkg}))
    .pipe(gulp.dest gutil.env.prefix)
    .pipe(connect.reload())
