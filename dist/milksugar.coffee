define 'milksugar/app', ['jquery'], ($) ->
  'use strict'
  
  class App
    
    constructor: (assets = ['image', 'view']) ->
      @screens = []
      @data = {}
      ###
      if assets? 
        check(assets)
          .array((v) ->
            for asset in v
              
            )
          .object((v) ->
            for key, value in v
              Assets.add(key, value)
            )
        if Array.isArray(assets)
          for asset in assets
            Assets.add(asset)
        else
          for key, value of assets
            Assets.add(key, value)
      ###
    
    addScreen: (screen) ->
      screens.push screen

    run: ->
      $title = $ 'title'

      if $title.html()? and @name?
        $('title').html @name
define 'milksugar/assets', ->
  "use strict";
   
  Assets =
    root: 'assets'
    add: (pathName, alias = "#{pathName}s") ->
      @[pathName] = (assetName) ->
        realPathName = if alias then alias else pathName
        MilkSugar.Assets.path MilkSugar.Assets.root, realPathName, assetName
    remove: (pathName) -> delete @[pathName] if @[pathName]
    path: (paths...) -> paths.join '/'
###
  Cloning objects
###
define 'clone', ->
  clone = (obj) ->
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
      newInstance[key] = clone obj[key]
  
    newInstance
do (root = @) ->
  ###
    Console object fixes
  ###
  noop = ->

  methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
        'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
        'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd',
        'timeStamp', 'trace', 'warn']

  console = (root.console or= {})

  for i in methods
    method = methods[i]
    
    console[method] or= noop


define('milksugar/core/console', ->  )
###
 Extending objects
###
define 'extend', ->
  extend = (target, objects...) ->
    for obj in objects
      for key, value of obj
        target[key] = value
  
    target
###
  Provides a hashcode for strings
###
define 'hashcode', ->
  hashCode = (str) ->
    hash = 0
  
    if @length == 0
      return hash
  
    for i in str
      char = str.charCodeAt(i)
      hash = ((hash << 5) - hash) + char
      hash = hash & hash # Convert to 32bit integer
  
    hash
do (root = @) ->
  define 'root', ->
    root

define 'milksugar/preloader', ['jquery'], ($) ->
  'use strict'
  
  class Preloader
    assetPromise = null
    
    constructor: (assets) ->
      if Array.isArray assets
        defer = $.Deferred()
        
        defer.resolve assets
        assetPromise = defer.promise()
      else
        assetPromise = $.ajax
          url: assets
          dataType: 'JSON'
      
    progressChange: ->
    done: ->
    
    start: ->
      assetPromise.done (assets) ->
        console.log assets        
define 'milksugar/router', ['root'], ->
  
  class Router
    constructor: (routes) ->
      root.routie routes
      
    call: (name) -> root.routie name

Widget = require './widget'

class Screen
  constructor: (options) ->
    @name = options.name || 'home'
    @route = "/#{@name}"
    @widgets = {}
    @template = ""

  addWidget: (widget) ->

  render: ->

Screen.$container = $('.screen-container')

module.exports = Screen

define('milksugar/screen', ->  )
define 'milksugar/ui/animation', ->
  'use strict'
  
  Animation =
    interval: 300

define 'milksugar/ui/lightbox', ->
  'use strict'
  
  class Lightbox
    constructor: ->

define 'milksugar/widget', ->
  'use strict'
   
  class Widget
    constructor: ->
      @data = {}
    