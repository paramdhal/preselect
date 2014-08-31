(function($, window, document) {
  var Plugin, defaults, pluginName;
  pluginName = "preselect";
  defaults = {
    select: "pre-selector",
    optionVal: "options"
  };
  Plugin = (function() {
    function Plugin(element, options) {
      this.element = element;
      this.settings = $.extend({}, defaults, options);
      this._defaults = defaults;
      this._name = pluginName;
      this.init();
    }

    Plugin.prototype.init = function() {
      var $el, name;
      $el = $(this.element);
      $el.on('change', $.proxy(this.preselect, this));
      name = $el.data(this.settings.select);
      return this.select = $("select[name=" + name + "]");
    };

    Plugin.prototype.preselect = function(e) {
      var option;
      option = $(this.element).find('option:selected').data(this.settings.optionVal);
      if (option) {
        return this.select.val(option);
      }
    };

    return Plugin;

  })();
  return $.fn[pluginName] = function(options) {
    return this.each(function() {
      if (!$.data(this, "plugin_" + pluginName)) {
        return $.data(this, "plugin_" + pluginName, new Plugin(this, options));
      }
    });
  };
})(jQuery, window, document);
