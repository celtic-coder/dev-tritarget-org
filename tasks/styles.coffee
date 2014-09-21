gulp           = require "gulp"
gutil          = require "gulp-util"
sass           = require "gulp-sass"
{includePaths} = require "node-bourbon"

# There is an odd race condition that causes the dest path to not be available
# when either browserify or metalsmith tasks are ran at the same time. We need
# to provide a dependency to delay this task till after the previous two tasks
# are complete. However calling the styles task directly does not need those
# dependencies and so we provide two tasks. An internal one and a user facing
# one since they both implement the same task.
stylesTask = ->
  gulp.src("#{gutil.env.projectdir}/scss/index.scss")
    .pipe(sass {includePaths})
    .pipe(gulp.dest gutil.env.prefix)

gulp.task "styles", stylesTask
gulp.task "styles-delayed", ["browserify", "metalsmith"], stylesTask
