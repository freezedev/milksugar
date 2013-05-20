define 'milksugar/view', ['check', 'jquery', 'handlebars'], (check, $, Handlebars) ->

  class MilkSugar.View    
    
    constructor: (@view) ->
    
    data: null
    subviews: []
    partials: []
    helpers: {}
    target: null
      
    render: (options) ->
      dataObject = null
      
      check(@data)
        .array((data) -> dataObject = $.when @data)
        .object((data) -> dataObject = $.Deferred((defer) -> defer.resolve([data])).promise())
        .string((data) -> dataObject = $.ajax data)
        
      check(@partials)
      
      check(@subviews)
      
      $.ajax(@view).done(->
        
      )