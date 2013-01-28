((window, MilkSugar, $, async) ->
  "use strict"
  
  class MilkSugar.Preloader
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
      
  
)(@, @MilkSugar or= {}, @jQuery, @async);
