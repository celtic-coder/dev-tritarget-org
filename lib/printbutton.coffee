$ = require "jquery"

class PrintButton
  print: -> window.print()

  init: -> $(".btn.print").on("click", @print)

module.exports = PrintButton
