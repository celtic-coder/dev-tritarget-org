fs     = require "fs"
header = require "gulp-header"

module.exports = (file, options) ->
    header fs.readFileSync(file, 'utf-8'), options
