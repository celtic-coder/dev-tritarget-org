gulp  = require "gulp"
gutil = require "gulp-util"
del   = require "del"

gulp.task "clean", (done) ->
  del(gutil.env.prefix, done)
