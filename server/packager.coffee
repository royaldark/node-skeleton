fs = require 'fs'
_ = require 'underscore'
async = require 'async'
Util = require './util.coffee'

Packager =
  _getContents: (files, dir, extension, next) ->
    index = -1 * extension.length

    validFiles = _.filter files, (filename) -> filename[index..] == extension

    async.map validFiles, (filename, next) ->
      fullFilename = "#{ dir }/#{ filename }"
      fs.readFile fullFilename, 'utf8', next
    , next

  packageCoffeeFiles: (next) ->
    await async.map ['./shared', './client'], fs.readdir, defer err, results
    return next(err) if err

    await async.parallel [
      (next) -> Packager._getContents results[0], './shared', '.coffee', next
      (next) -> Packager._getContents results[1], './client', '.coffee', next
    ], defer err, contents
    return next(err) if err
    
    compiled = Util.compile _.flatten(contents).join('\n\n')
    next(null, compiled)

  packageTemplates: (next) ->
    views = {}

    await fs.readdir './templates', defer err, files
    return next(err) if err

    await Packager._getContents files, './templates', '.html', defer err, templates
    return next(err) if err

    next(null, "var templates = #{ JSON.stringify(templates) };")


module.exports = Packager
