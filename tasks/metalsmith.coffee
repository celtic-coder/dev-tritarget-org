fs          = require "fs"
path        = require "path"
gulp        = require "gulp"
gutil       = require "gulp-util"
connect     = require "gulp-connect"
metalsmith  = require "metalsmith"
markdown    = require "metalsmith-markdown"
templates   = require "metalsmith-templates"
collections = require "metalsmith-collections"
permalinks  = require "metalsmith-permalinks"
site        = require "../site.json"
pkg         = require "../package.json"

templateDir = "templates"

collectionsConfig =
  blog:
    pattern: "posts/*.md"
    sortBy:  'date'
    reverse: true

gulp.task "metalsmith", (done) ->
  addPartials = (memo, file) ->
    name = file.match /^_(.+)\..+$/
    memo[name[1]] = "_#{name[1]}" if name?
    memo

  finished = ->
    connect.reload().write(path: "Content files")
    done()

  partials = fs.readdirSync(path.join gutil.env.projectdir, templateDir)
    .reduce(addPartials, {})

  metalsmith(gutil.env.projectdir)
    .clean(false)
    .metadata({site, pkg})
    .use(collections(collectionsConfig))
    .use(markdown())
    .use(permalinks(
      pattern: ":collection/:date/:title"
      date:    "YYYY/MM/DD"
    ))
    .use(templates {engine: "handlebars", partials})
    .destination(gutil.env.prefix)
    .build(finished)
