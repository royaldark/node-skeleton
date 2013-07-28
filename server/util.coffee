crypto = require 'crypto'
fs = require 'fs'
less = require 'less'
coffee = require 'coffee-script'
_ = require 'underscore'

# Monkey-patch some custom fns into Underscore
_.mapObj = _.compose(_.object, _.map)


Util =
  compile: coffee.compile
  
  compileCSS: less.render

module.exports = Util
