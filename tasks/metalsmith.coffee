gulp       = require "gulp"
gutil      = require "gulp-util"
metalsmith = require "metalsmith"
markdown   = require "metalsmith-markdown"
templates  = require "metalsmith-templates"

gulp.task "metalsmith", (done) ->
  metalsmith(gutil.env.projectdir)
  .use(markdown())
  .use(templates 'handlebars')
  .destination(gutil.env.prefix)
  .build(done)
