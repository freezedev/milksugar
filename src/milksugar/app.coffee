((window, MilkSugar, $) ->
  "use strict"
  
  # Rebind method for JSHint
  check = window.check
  
  class MilkSugar.App
    
    constructor: (assets = ['image', 'view']) ->
      if assets? 
        check(assets)
          .array((v) ->
            for asset in v
              
            )
          .object((v) ->
            for key, value in v
              MilkSugar.Assets.add(key, value)
            )
        if Array.isArray(assets)
          for asset in assets
            MilkSugar.Assets.add(asset)
        else
          for key, value of assets
            MilkSugar.Assets.add(key, value)
      
    run: ->
      $('title').html @name if @name
      
  
)(@, @MilkSugar or= {}, @jQuery)