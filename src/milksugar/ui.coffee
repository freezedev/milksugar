do (window = @, MilkSugar = @MilkSugar or= {}, $ = @jQuery) ->

  MilkSugar.UI or= {}
  
  MilkSugar.UI.Animation =
    interval: 300
  
  MilkSugar.UI.Lightbox = do ->
    show: ->

    {show}
