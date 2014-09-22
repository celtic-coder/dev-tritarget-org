fs         = require "fs"
path       = require "path"
gulp       = require "gulp"
gutil      = require "gulp-util"
metalsmith = require "metalsmith"
markdown   = require "metalsmith-markdown"
templates  = require "metalsmith-templates"
site       = require "../site.json"
pkg        = require "../package.json"

templateDir = "templates"

gulp.task "metalsmith", (done) ->
  addPartials = (memo, file) ->
    name = file.match /^_(.+)\..+$/
    memo[name[1]] = "_#{name[1]}" if name?
    memo

  finished = ->
    done()

  partials = fs.readdirSync(path.join gutil.env.projectdir, templateDir)
    .reduce(addPartials, {})

  metalsmith(gutil.env.projectdir)
    .clean(false)
    .metadata({site, pkg})
    .use(markdown())
    .use(templates {engine: "handlebars", partials})
    .destination(gutil.env.prefix)
    .build(finished)
