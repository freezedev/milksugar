(function() {
  var __slice = [].slice;

  define('milksugar/app', ['check', 'jquery', 'milksugar/assets'], function(check, $, Assets) {
    'use strict';
    var App;

    return App = (function() {
      function App(assets) {
        if (assets == null) {
          assets = ['image', 'view'];
        }
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

      App.prototype.run = function() {
        if (this.name) {
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
          alias = "" + pathName + "s";
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

        paths = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return paths.join('/');
      }
    };
  });

  define('milksugar/capsule', function() {
    'use strict';    return MilkSugar.Capsule = (function() {
      function Capsule() {}

      return Capsule;

    })();
  });

  define("requestAnimationFrame", ["root"], function(root) {
    var frameRate, requestAnimationFrame, vendors, x;

    frameRate = 60;
    requestAnimationFrame = root.requestAnimationFrame;
    vendors = ["ms", "moz", "webkit", "o"];
    x = 0;
    while (x < vendors.length && !window.requestAnimationFrame) {
      requestAnimationFrame = root[vendors[x] + "RequestAnimationFrame"];
      if (requestAnimationFrame) {
        break;
      }
      ++x;
    }
    if (!requestAnimationFrame) {
      requestAnimationFrame = function(callback) {
        return window.setTimeout(callback, ~~(1000 / window.frameRate));
      };
    }
    return requestAnimationFrame;
  });

  define("cancelAnimationFrame", ["root"], function(root) {
    var cancelAnimationFrame, cancelRequestAnimationFrame, vendors, x;

    cancelAnimationFrame = root.cancelAnimationFrame;
    vendors = ["ms", "moz", "webkit", "o"];
    x = 0;
    while (x < vendors.length && !window.requestAnimationFrame) {
      cancelRequestAnimationFrame = root[vendors[x] + "CancelRequestAnimationFrame"];
      if (cancelAnimationFrame) {
        break;
      }
      ++x;
    }
    if (!cancelAnimationFrame) {
      return cancelAnimationFrame = function(id) {
        return clearTimeout(id);
      };
    }
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

    var console, i, method, methods, noop, _i, _len, _results;

    noop = function() {};
    methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
    console = (root.console || (root.console = {}));
    _results = [];
    for (_i = 0, _len = methods.length; _i < _len; _i++) {
      i = methods[_i];
      method = methods[i];
      _results.push(console[method] || (console[method] = noop));
    }
    return _results;
  })(this);

  /*
   Extending objects
  */


  define('extend', function() {
    var extend;

    return extend = function() {
      var key, obj, objects, target, value, _i, _len;

      target = arguments[0], objects = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      for (_i = 0, _len = objects.length; _i < _len; _i++) {
        obj = objects[_i];
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
      var char, hash, i, _i, _len;

      hash = 0;
      if (this.length === 0) {
        return hash;
      }
      for (_i = 0, _len = str.length; _i < _len; _i++) {
        i = str[_i];
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

  define('milksugar/view', ['check', 'jquery', 'handlebars'], function(check, $, Handlebars) {
    return MilkSugar.View = (function() {
      function View(view) {
        this.view = view;
      }

      View.prototype.data = null;

      View.prototype.subviews = [];

      View.prototype.partials = [];

      View.prototype.helpers = {};

      View.prototype.target = null;

      View.prototype.render = function(options) {
        var dataObject;

        dataObject = null;
        check(this.data).array(function(data) {
          return dataObject = $.when(this.data);
        }).object(function(data) {
          return dataObject = $.Deferred(function(defer) {
            return defer.resolve([data]);
          }).promise();
        }).string(function(data) {
          return dataObject = $.ajax(data);
        });
        check(this.partials);
        check(this.subviews);
        return $.ajax(this.view).done(function() {});
      };

      return View;

    })();
  });

}).call(this);

/*
//@ sourceMappingURL=milksugar.js.map
*/