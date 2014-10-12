gulp       = require "gulp"
gutil      = require "gulp-util"
path       = require "path"
fs         = require "fs"
source     = require "vinyl-source-stream"
browserify = require "browserify"
mold       = require "mold-source-map"
gulpif     = require "gulp-if"
uglify     = require "gulp-uglify"
streamify  = require "gulp-streamify"
connect    = require "gulp-connect"
preamble   = require "../plugins/preamble"

headerFile     = "preamble.ejs"
outputFileName = "index.js"
outputDest      = path.join gutil.env.prefix, "js"

gulp.task "browserify", ->
  pkg          = require(path.join gutil.env.projectdir, "package.json")
  preamblePath = path.join gutil.env.projectdir, headerFile
  bundlePath   = path.join gutil.env.projectdir, "/lib/index.coffee"

  browserify(bundlePath, entry: true, debug: !gutil.env.prod)
    .bundle()
    .pipe(gulpif !gutil.env.prod, mold.transformSourcesRelativeTo(outputDest))
    .pipe(source outputFileName)
    .pipe(gulpif gutil.env.prod, streamify uglify())
    .pipe(preamble(preamblePath, {pkg}))
    .pipe(gulp.dest outputDest)
    .pipe(connect.reload())
