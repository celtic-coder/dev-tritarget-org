_            = require "lodash"
fs           = require "fs"
path         = require "path"
gulp         = require "gulp"
gutil        = require "gulp-util"
connect      = require "gulp-connect"
metalsmith   = require "metalsmith"
markdown     = require "metalsmith-markdown"
templates    = require "metalsmith-templates"
collections  = require "metalsmith-collections"
permalinks   = require "metalsmith-permalinks"
more         = require "metalsmith-more"
findTemplate = require "../plugins/findtemplate"
site         = require "../site.json"
pkg          = require "../package.json"

templateDir = path.join gutil.env.projectdir, "templates"
helpersDir  = path.join gutil.env.projectdir, "helpers"

collectionsConfig =
  blog:
    pattern: "posts/*.md"
    sortBy:  'date'
    reverse: true

addPartials = ->
  partialFilter = /^_(.+)/
  (memo, file) ->
    name = path.basename(file, ".hbs").match partialFilter
    memo[name[1]] = "_#{name[1]}" if name?
    memo

loadHelpers = ->
  (memo, file) ->
    module = require(path.join helpersDir, file)
    if _.isFunction(module)
      name = path.basename(file, path.extname file)
      memo[name] = module
    else
      _.extend(memo, module)
    memo

gulp.task "metalsmith", (done) ->
  finished = (err) ->
    connect.reload().write(path: "Content files")
    done(err)

  partials = _(fs.readdirSync templateDir).reduce(addPartials(), {})
  helpers  = _(fs.readdirSync helpersDir).reduce(loadHelpers(), {})

  metalsmith(gutil.env.projectdir)
    .clean(false)
    .metadata({site, pkg})
    .use(collections(collectionsConfig))
    .use(markdown())
    .use(permalinks(
      relative: false
      pattern: ":collection/:date/:title"
      date:    "YYYY/MM/DD"
    ))
    .use(findTemplate(
      pattern:      "blog"
      templateName: "post.hbs"
    ))
    .use(templates {engine: "handlebars", partials, helpers})
    .use(more())
    .destination(gutil.env.prefix)
    .build(finished)
