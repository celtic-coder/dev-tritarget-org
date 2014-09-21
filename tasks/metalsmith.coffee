fs         = require "fs"
path       = require "path"
gulp       = require "gulp"
gutil      = require "gulp-util"
metalsmith = require "metalsmith"
markdown   = require "metalsmith-markdown"
templates  = require "metalsmith-templates"

templateDir = "templates"

gulp.task "metalsmith", (done) ->
  addPartials = (memo, file) ->
    name = file.match /^_(.+)\..+$/
    memo[name[1]] = "_#{name[1]}" if name?
    memo

  partials = fs.readdirSync(path.join gutil.env.projectdir, templateDir)
    .reduce(addPartials, {})

  metalsmith(gutil.env.projectdir)
  .use(markdown())
  .use(templates {engine: "handlebars", partials})
  .destination(gutil.env.prefix)
  .build(done)
