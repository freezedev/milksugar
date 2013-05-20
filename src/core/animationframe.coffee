define "requestAnimationFrame", ["root"], (root) ->
  
  # frameRate is only used if requestAnimationFrame is not available
  frameRate = 60
  requestAnimationFrame = root.requestAnimationFrame
  vendors = ["ms", "moz", "webkit", "o"]
  x = 0

  while x < vendors.length and not window.requestAnimationFrame
    requestAnimationFrame = root[vendors[x] + "RequestAnimationFrame"]
    break  if requestAnimationFrame
    ++x
  unless requestAnimationFrame
    requestAnimationFrame = (callback) ->
      window.setTimeout callback, ~~(1000 / window.frameRate)
  requestAnimationFrame

define "cancelAnimationFrame", ["root"], (root) ->
  cancelAnimationFrame = root.cancelAnimationFrame
  vendors = ["ms", "moz", "webkit", "o"]
  x = 0

  while x < vendors.length and not window.requestAnimationFrame
    cancelRequestAnimationFrame = root[vendors[x] + "CancelRequestAnimationFrame"]
    break  if cancelAnimationFrame
    ++x
  unless cancelAnimationFrame
    cancelAnimationFrame = (id) ->
      clearTimeout id
