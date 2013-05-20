define 'milksugar/app', ['check', 'jquery', 'milksugar/assets'], (check, $, Assets) ->
  'use strict'
  
  class App
    
    constructor: (assets = ['image', 'view']) ->
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
      
    run: ->
      $('title').html @name if @name