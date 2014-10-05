gulp  = require "gulp"
gutil = require "gulp-util"

gulp.task "default", ["metalsmith", "contact-data", "browserify", "styles"], ->
  environment = if gutil.env.prod
    gutil.colors.blue "production"
  else
    gutil.colors.green "development"

  gutil.log "Build environment: #{environment}"
