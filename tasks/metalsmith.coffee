_                = require "lodash"
fs               = require "fs"
path             = require "path"
gulp             = require "gulp"
gutil            = require "gulp-util"
connect          = require "gulp-connect"
metalsmith       = require "metalsmith"
markdown         = require "metalsmith-markdown"
collections      = require "metalsmith-collections"
permalinks       = require "metalsmith-permalinks"
more             = require "metalsmith-more"
tags             = require "metalsmith-tags"
highlight        = require "metalsmith-metallic"
pageTemplates    = require "metalsmith-templates"
hbHelpers        = require "diy-handlebars-helpers"
contentTemplates = require "../plugins/pretemplates"
findTemplate     = require "../plugins/findtemplate"
site             = require "../site.json"
pkg              = require "../package.json"

templateDir = path.join gutil.env.projectdir, "templates"
helpersDir  = path.join gutil.env.projectdir, "helpers"

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
    connect.reload().write(path: "Content files") unless err
    done(err)

  templateOptions =
    engine:   "handlebars"
    partials: _(fs.readdirSync templateDir).reduce(addPartials(), {})
    helpers:  _(fs.readdirSync helpersDir).chain()
      .reduce(loadHelpers(), {})
      .extend(hbHelpers)
      .value()

  metalsmith(gutil.env.projectdir)
    .clean(false)
    .metadata({site, pkg})
    .use(collections(
      blog:
        pattern: "posts/*.md"
        sortBy:  "date"
        reverse: true
    ))
    .use(highlight(tabReplace: "  "))
    .use(markdown())
    .use(more())
    .use(findTemplate(
      collection:   "blog"
      templateName: "post.hbs"
    ))
    .use(tags(
      handle:   "categories"
      path:     "categories"
      template: "tags.hbs"
      sortBy:   "date"
      reverse:  true
    ))
    .use(permalinks(
      relative: false
      pattern: ":collection/:date/:title"
      date:    "YYYY/MM/DD"
    ))
    .use(contentTemplates templateOptions)
    .use(pageTemplates templateOptions)
    .destination(gutil.env.prefix)
    .build(finished)
