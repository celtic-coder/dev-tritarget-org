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
gist             = require "metalsmith-gist"
hbHelpers        = require "diy-handlebars-helpers"
contentTemplates = require "../plugins/pretemplates"
findTemplate     = require "../plugins/findtemplate"
site             = require "../site.json"
pkg              = require "../package.json"

templateDir = path.join gutil.env.projectdir, "templates"
helpersDir  = path.join gutil.env.projectdir, "helpers"

addPartials = (transFn) ->
  partialFilter = /^_(.+)/
  (memo, file) ->
    name = path.basename(file, ".hbs").match partialFilter
    memo[name[1]] = transFn(file, name[1]) if name?
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

build = (sourceDir="./src", done) ->
  finished = (err) ->
    connect.reload().write(path: sourceDir) unless err
    done(err)

  partialFileNames = fs.readdirSync templateDir
  partials =
    names: _(partialFileNames).reduce(
      addPartials((file, name) -> "_#{name}")
      {}
    )
    files: _(partialFileNames).reduce(
      addPartials((file) -> path.join(templateDir, file))
      {}
    )

  templateOptions =
    engine:   "handlebars"
    helpers:  _(fs.readdirSync helpersDir).chain()
      .reduce(loadHelpers(), {})
      .extend(hbHelpers)
      .value()

  site.time = new Date()

  metalsmith(gutil.env.projectdir)
    .source(sourceDir)
    .clean(false)
    .metadata({site, pkg})
    .use(collections(
      blog:
        pattern: "posts/*.md"
        sortBy:  "date"
        reverse: true
    ))
    .use(tags(
      handle:   "tags"
      path:     "categories"
      template: "categories.hbs"
      sortBy:   "date"
      reverse:  true
    ))
    .use(findTemplate(
      collection:   "blog"
      templateName: "post.hbs"
    ))
    .use(contentTemplates _.extend({}, templateOptions, partials: partials.files))
    .use(highlight(tabReplace: "  "))
    .use(markdown())
    .use(gist())
    .use(more())
    .use(permalinks(
      relative: false
      pattern: ":collection/:date/:title"
      date:    "YYYY/MM/DD"
    ))
    .use(pageTemplates _.extend({}, templateOptions, partials: partials.names))
    .destination(gutil.env.prefix)
    .build(finished)

gulp.task "pages", (done) -> build("./src", done)
gulp.task "posts", (done) -> build("./src", done)
gulp.task "metalsmith", ["pages", "posts"]
