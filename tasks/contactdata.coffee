gulp         = require "gulp"
gutil        = require "gulp-util"
gulpif       = require "gulp-if"
connect      = require "gulp-connect"
encrypt      = require "bad-cipher/gulp-encrypt"
{existsSync} = require "fs"

contactInfoFile = "./info.json"

gulp.task "contact-data", ->
  if existsSync(contactInfoFile)
    gulp.src("./info.json")
    .pipe(gulpif gutil.env.prod, encrypt())
    .pipe(gulp.dest gutil.env.prefix)
    .pipe(connect.reload())
  else
    gutil.log gutil.colors.red("Missing #{contactInfoFile}")
