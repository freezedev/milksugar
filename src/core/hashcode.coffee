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