(function() {
  var Screen, Widget,
    slice = [].slice;

  define('milksugar/app', ['jquery'], function($) {
    'use strict';
    var App;
    return App = (function() {
      function App(assets) {
        if (assets == null) {
          assets = ['image', 'view'];
        }
        this.screens = [];
        this.data = {};

        /*
        if assets? 
          check(assets)
            .array((v) ->
              for asset in v
                
              )
            .object((v) ->
              for key, value in v
                Assets.add(key, value)
              )
          if Array.isArray(assets)
            for asset in assets
              Assets.add(asset)
          else
            for key, value of assets
              Assets.add(key, value)
         */
      }

      App.prototype.addScreen = function(screen) {
        return screens.push(screen);
      };

      App.prototype.run = function() {
        var $title;
        $title = $('title');
        if (($title.html() != null) && (this.name != null)) {
          return $('title').html(this.name);
        }
      };

      return App;

    })();
  });

  define('milksugar/assets', function() {
    "use strict";
    var Assets;
    return Assets = {
      root: 'assets',
      add: function(pathName, alias) {
        if (alias == null) {
          alias = pathName + "s";
        }
        return this[pathName] = function(assetName) {
          var realPathName;
          realPathName = alias ? alias : pathName;
          return MilkSugar.Assets.path(MilkSugar.Assets.root, realPathName, assetName);
        };
      },
      remove: function(pathName) {
        if (this[pathName]) {
          return delete this[pathName];
        }
      },
      path: function() {
        var paths;
        paths = 1 <= arguments.length ? slice.call(arguments, 0) : [];
        return paths.join('/');
      }
    };
  });


  /*
    Cloning objects
   */

  define('clone', function() {
    var clone;
    return clone = function(obj) {
      var flags, key, newInstance;
      if ((obj == null) || typeof obj !== 'object') {
        return obj;
      }
      if (obj instanceof Date) {
        return new Date(obj.getTime());
      }
      if (obj instanceof RegExp) {
        flags = '';
        if (obj.global != null) {
          flags += 'g';
        }
        if (obj.ignoreCase != null) {
          flags += 'i';
        }
        if (obj.multiline != null) {
          flags += 'm';
        }
        if (obj.sticky != null) {
          flags += 'y';
        }
        return new RegExp(obj.source, flags);
      }
      newInstance = new obj.constructor();
      for (key in obj) {
        newInstance[key] = clone(obj[key]);
      }
      return newInstance;
    };
  });

  (function(root) {

    /*
      Console object fixes
     */
    var console, i, j, len, method, methods, noop, results;
    noop = function() {};
    methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
    console = (root.console || (root.console = {}));
    results = [];
    for (j = 0, len = methods.length; j < len; j++) {
      i = methods[j];
      method = methods[i];
      results.push(console[method] || (console[method] = noop));
    }
    return results;
  })(this);

  define('milksugar/core/console', function() {});


  /*
   Extending objects
   */

  define('extend', function() {
    var extend;
    return extend = function() {
      var j, key, len, obj, objects, target, value;
      target = arguments[0], objects = 2 <= arguments.length ? slice.call(arguments, 1) : [];
      for (j = 0, len = objects.length; j < len; j++) {
        obj = objects[j];
        for (key in obj) {
          value = obj[key];
          target[key] = value;
        }
      }
      return target;
    };
  });


  /*
    Provides a hashcode for strings
   */

  define('hashcode', function() {
    var hashCode;
    return hashCode = function(str) {
      var char, hash, i, j, len;
      hash = 0;
      if (this.length === 0) {
        return hash;
      }
      for (j = 0, len = str.length; j < len; j++) {
        i = str[j];
        char = str.charCodeAt(i);
        hash = ((hash << 5) - hash) + char;
        hash = hash & hash;
      }
      return hash;
    };
  });

  (function(root) {
    return define('root', function() {
      return root;
    });
  })(this);

  define('milksugar/preloader', ['jquery'], function($) {
    'use strict';
    var Preloader;
    return Preloader = (function() {
      var assetPromise;

      assetPromise = null;

      function Preloader(assets) {
        var defer;
        if (Array.isArray(assets)) {
          defer = $.Deferred();
          defer.resolve(assets);
          assetPromise = defer.promise();
        } else {
          assetPromise = $.ajax({
            url: assets,
            dataType: 'JSON'
          });
        }
      }

      Preloader.prototype.progressChange = function() {};

      Preloader.prototype.done = function() {};

      Preloader.prototype.start = function() {
        return assetPromise.done(function(assets) {
          return console.log(assets);
        });
      };

      return Preloader;

    })();
  });

  define('milksugar/router', ['root'], function() {
    var Router;
    return Router = (function() {
      function Router(routes) {
        root.routie(routes);
      }

      Router.prototype.call = function(name) {
        return root.routie(name);
      };

      return Router;

    })();
  });

  Widget = require('./widget');

  Screen = (function() {
    function Screen(options) {
      this.name = options.name || 'home';
      this.route = "/" + this.name;
      this.widgets = {};
      this.template = "";
    }

    Screen.prototype.addWidget = function(widget) {};

    Screen.prototype.render = function() {};

    return Screen;

  })();

  Screen.$container = $('.screen-container');

  module.exports = Screen;

  define('milksugar/screen', function() {});

  define('milksugar/ui/animation', function() {
    'use strict';
    var Animation;
    return Animation = {
      interval: 300
    };
  });

  define('milksugar/ui/lightbox', function() {
    'use strict';
    var Lightbox;
    return Lightbox = (function() {
      function Lightbox() {}

      return Lightbox;

    })();
  });

  define('milksugar/widget', function() {
    'use strict';
    return Widget = (function() {
      function Widget() {
        this.data = {};
      }

      return Widget;

    })();
  });

}).call(this);

//# sourceMappingURL=milksugar.js.map
