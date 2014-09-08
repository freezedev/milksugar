define 'milksugar/screen', ->
  
  class Screen
    constructor: (options) ->
      @name = options.name || 'home'
      @route = '/' + @name
      
      
    add: ->
