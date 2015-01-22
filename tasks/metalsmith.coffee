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
lunr             = require "metalsmith-lunr"
hbHelpers        = require "diy-handlebars-helpers"
contentTemplates = require "../plugins/pretemplates"
findTemplate     = require "../plugins/findtemplate"
lunrMetadata     = require "../plugins/lunr-metadata"
site             = require "../site.json"
pkg              = require "../package.json"

templateDir = path.join gutil.env.projectdir, "templates"
helpersDir  = path.join gutil.env.projectdir, "helpers"

SEARCH_INDEX_JSON = "search-index.json"

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

profile = (name, fn) ->
  return fn unless gutil.env.profile?

  timeStart = null
  timeStop  = null
  (files, metalsmith, done) ->
    end = (args...) ->
      timeStop = new Date().getTime()
      console.log "#{name}: #{timeStop - timeStart}ms"
      done(args...)
    timeStart = new Date().getTime()
    fn(files, metalsmith, end)

stripHtml = ->
  console.log "here"

lunrProcess = (indexPath) ->
  lunr {
    indexPath
    ref: "title"
    preprocess: stripHtml
    fields:
      path:     1
      contents: 1
      tags:     10
      title:    20
  }

gulp.task "metalsmith", (done) ->
  finished = (err) ->
    connect.reload().write(path: "Content files") unless err
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
    .clean(false)
    .metadata({site, pkg})
    .use(profile "collections", collections(
      blog:
        pattern: "posts/*.md"
        sortBy:  "date"
        reverse: true
    ))
    .use(profile "tags", tags(
      handle:   "tags"
      path:     "categories"
      template: "categories.hbs"
      sortBy:   "date"
      reverse:  true
    ))
    .use(profile "findTemplate", findTemplate(
      collection:   "blog"
      templateName: "post.hbs"
    ))
    .use(profile "contentTemplates", contentTemplates(_.extend {}, templateOptions, partials: partials.files))
    .use(profile "highlight", highlight(tabReplace: "  "))
    .use(profile "markdown", markdown())
    .use(profile "gist", gist())
    .use(profile "more", more())
    .use(profile "permalinks", permalinks(
      relative: false
      pattern: ":collection/:date/:title"
      date:    "YYYY/MM/DD"
    ))
    .use(profile "pageTemplates", pageTemplates(_.extend {}, templateOptions, partials: partials.names))
    .use(profile "lunrMetadata", lunrMetadata(default: gutil.env.prod?))
    .use(profile "lunrProcess", lunrProcess(SEARCH_INDEX_JSON))
    .destination(gutil.env.prefix)
    .build(finished)
