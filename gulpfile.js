require('coffee-script/register');
var gutil     = require('gulp-util');
var fs        = require('fs');
var path      = require('path');
var tasksPath = path.join(__dirname, 'tasks');

gutil.env.projectdir = __dirname;
gutil.env.prefix = gutil.env.prefix || 'build';

fs.readdirSync(tasksPath)
.forEach(function(module) {
  if (/\.coffee$|\.js$/.test(module)) {
    require(path.join(tasksPath, module));
  }
});
