((window, document, String) -> 
  "use strict";
  
  ###
    Console object fixes
  ###
  noop = ->

  methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
        'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
        'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd',
        'timeStamp', 'trace', 'warn']

  console = (window.console or= {})

  for i in methods
    method = methods[i]
    
    console[method] or= noop

  ###
   Extending objects
  ###
  window.extend = (target, objects...) ->
    for obj in objects
      for key, value of obj
        target[key] = value
  
    target

  ###
    Cloning objects
  ###
  window.clone = (obj) ->
    if not obj? or typeof obj isnt 'object'
      return obj
  
    if obj instanceof Date
      return new Date(obj.getTime()) 
  
    if obj instanceof RegExp
      flags = ''
      flags += 'g' if obj.global?
      flags += 'i' if obj.ignoreCase?
      flags += 'm' if obj.multiline?
      flags += 'y' if obj.sticky?
      return new RegExp(obj.source, flags) 
  
    newInstance = new obj.constructor()
  
    for key of obj
      newInstance[key] = window.clone obj[key]
  
    newInstance

  ###
    'is' is a pretty good function name in my opinion, 
    but already a pre-defined keyword in CoffeeScript, 
    'check' is a better function name if you want to just 
    use the function without the 'window' prefix
  ###
  window.is = window.check = (variable) ->
    "use strict"
  
    stringedVar = {}.toString.call variable
    typeName = stringedVar.slice(8, stringedVar.length - 1).toLowerCase() 
  
    checkType = (typeString, cb, inverse) ->
      if inverse
        cb?(variable) unless typeName is typeString
      else  
        cb?(variable) if typeName is typeString
      result
  
    types = (inverse) ->
      valid: (cb) ->
        if inverse
          cb(variable) unless variable?
        else
          cb(variable) if variable?
        @
      undefined: (cb) -> checkType "undefined", cb, inverse
      null: (cb) -> checkType "null", cb, inverse
      string: (cb) -> checkType "string", cb, inverse
      number: (cb) -> checkType "number", cb, inverse
      object: (cb) -> checkType "object", cb, inverse
      array: (cb) -> checkType "array", cb, invserse
      function: (cb) -> checkType "function", cb, inverse
  
    result = types(false)
    result.not = types(true)
    
    result

  ###
    Provides a hashcode for strings
  ###
  String::hashCode = ->
    hash = 0
  
    if @length == 0
      return hash
  
    for i in @
      char = @charCodeAt(i)
      hash = ((hash << 5) - hash) + char
      hash = hash & hash # Convert to 32bit integer
  
    hash
  
  ###
    Syntactic sugar for properties
  ###
  Function::property = (prop, desc) ->
    Object.defineProperty @prototype, prop, desc

  ###
   requestAnim shim layer by Paul Irish
  ###
  lastTime = 0
  vendors = ["ms", "moz", "webkit", "o"]

  for x in vendors
    window.requestAnimationFrame = window[vendors[x] + "RequestAnimationFrame"]
    window.cancelAnimationFrame = window[vendors[x] + "CancelAnimationFrame"] or window[vendors[x] + "CancelRequestAnimationFrame"]

  unless window.requestAnimationFrame
    window.requestAnimationFrame = (callback, element) ->
      currTime = Date.now()
      timeToCall = Math.max(0, 16 - (currTime - lastTime))
      id = window.setTimeout(->
        callback currTime + timeToCall
      , timeToCall)
      lastTime = currTime + timeToCall
      id
      
  unless window.cancelAnimationFrame
    window.cancelAnimationFrame = (id) ->
      clearTimeout id

  null # Return null
  
)(@, document, String) 