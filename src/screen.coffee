define ->
  
  class Screen
    constructor: (options) ->
      @name = options.name || 'home'
      @route = '/' + @name
      
      
    addWidget: (widget) ->
      
