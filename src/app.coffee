define ['jquery'], ($) ->
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