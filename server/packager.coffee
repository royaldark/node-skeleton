fs = require 'fs'
Util = require './util.coffee'

Packager =
  packageCoffeeFiles: ->
    coffeeContents = for file in fs.readdirSync './client' when file[-7..] == '.coffee'
      fs.readFileSync("./client/#{ file }", 'utf8')

    Util.compile coffeeContents.join('\n\n')

  packageTemplates: ->
    views = {}

    for file in fs.readdirSync './templates' when file[-5..] == '.html'
        views[file[0...-5]] = "#{ fs.readFileSync "./templates/#{ file }" }"

    "var templates = #{ JSON.stringify(views) };"


module.exports = Packager
