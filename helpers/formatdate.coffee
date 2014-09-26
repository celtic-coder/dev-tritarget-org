moment = require "moment"

formatDate = (date, format) ->
  moment(date).format(format)

formatDateYMD = (date) ->
  formatDate(date, "YYYY-MM-DD")

module.exports = {
  formatDate
  formatDateYMD
}
