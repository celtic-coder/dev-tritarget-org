gulp       = require "gulp"
gutil      = require "gulp-util"
path       = require "path"
fs         = require "fs"
es         = require "event-stream"
source     = require "vinyl-source-stream"
browserify = require "browserify"
gulpif     = require "gulp-if"
uglify     = require "gulp-uglify"
streamify  = require "gulp-streamify"
concat     = require "gulp-concat"
header     = require "gulp-header"

bowerDir = "./bower_components"

globalBowerLibs = [
  "bootstrap-sass-official/assets/javascripts/bootstrap.js"
]

headerFile     = "preamble.ejs"
outputFileName = "index.js"

gulp.task "browserify", ->
  pkg          = require(path.join gutil.env.projectdir, "package.json")
  preamblePath = path.join gutil.env.projectdir, headerFile

  globalLibPaths = for lib in globalBowerLibs
    path.join(gutil.env.projectdir, bowerDir, lib)

  bundle = browserify(path.join gutil.env.projectdir, "/lib/index.coffee")
    .bundle()
    .pipe(source outputFileName)

  es.concat(gulp.src(globalLibPaths), bundle)
    .pipe(streamify concat(outputFileName))
    .pipe(gulpif gutil.env.prod, uglify())
    .pipe(header fs.readFileSync(preamblePath, 'utf-8'), {pkg})
    .pipe(gulp.dest gutil.env.prefix)
