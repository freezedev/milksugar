define ['root'], ->
  
  class Router
    constructor: (routes) ->
      root.routie routes
      
    call: (name) -> root.routie name
