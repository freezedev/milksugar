do (window = @, MilkSugar = @MilkSugar or= {}) ->
  "use strict";
   
  MilkSugar.Assets =
    root: 'assets'
    add: (pathName, alias = "#{pathName}s") ->
      @[pathName] = (assetName) ->
        realPathName = if alias then alias else pathName
        MilkSugar.Assets.path MilkSugar.Assets.root, realPathName, assetName
    remove: (pathName) -> delete @[pathName] if @[pathName]
    path: (paths...) -> paths.join '/'