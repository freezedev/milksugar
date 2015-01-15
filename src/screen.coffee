define ['./widget'] ->
  
  class Screen
    constructor: (options) ->
      @name = options.name || 'home'
      @route = "/#{@name}"
      @widgets = {}
      @template = ""

    addWidget: (widget) ->

    render: ->

  Screen.$container = $('.screen-container')