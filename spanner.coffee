path = require 'path'
fs = require 'graceful-fs'

walkFiles = (dir, action, done) ->
  dead = false
  pending = 0

  fail = (err) ->
    unless dead
      dead = true
      done err

  checkSuccess = ->
    done() if not dead and pending is 0

  performAction = (file, stat) ->
    unless dead
      try
        action file, stat
      catch error
        fail error

  dive = (dir) ->
    pending++
    fs.readdir dir, (err, list) ->
      unless dead
        if err
          fail err
        else
          list.forEach (file) ->
            unless dead
              pathName = path.join(dir, file)
              pending++
              fs.stat pathName, (err, stat) ->
                unless dead
                  if err
                    fail err
                  else
                    if stat and stat.isDirectory()
                      dive pathName
                    else
                      performAction pathName, stat
                    pending--
                    checkSuccess()


          pending--
          checkSuccess()


  dive dir


getFilesRecursively = (root, options, callback) ->
  callback = options if typeof options is 'function'
  curFiles = []
  walkFiles root, ((file, stat) ->
    return  if file.contains(path.sep + '.') unless options.dotFiles
    return  if file.contains(path.sep + '_') unless options.underscoreFiles
    return  if options.filter.indexOf(path.extname(file)) is -1  if options.filter
    relPath = file.split(root + path.sep)[1]
    relPath.split(path.sep).join '/' if path.sep is '\\'
    curFiles.push
      fullname: file
      relname: relPath
      basename: path.basename(file)

  ), ->
    callback curFiles

exports.getFilesRecursively = getFilesRecursively