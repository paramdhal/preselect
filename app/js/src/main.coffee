do ($ = jQuery, window, document) ->

	pluginName = "preselect"
	defaults =
		select: "pre-selector"
		optionVal: "options"

	class Plugin
		constructor: (@element, options) ->
			@settings = $.extend {}, defaults, options
			@_defaults = defaults
			@_name = pluginName
			@init()

		init: ->
			$el = $(@element)
			$el.on 'change', $.proxy @preselect,this

			name = $el.data @settings.select
			@select = $("select[name=#{name}]")

		preselect: (e)->
			option = $(@element)
						.find 'option:selected'
						.data @settings.optionVal

			@select.val option if option

	# A really lightweight plugin wrapper around the constructor,
	# preventing against multiple instantiations
	$.fn[pluginName] = (options) ->
		@each ->
			unless $.data @, "plugin_#{pluginName}"
				$.data @, "plugin_#{pluginName}", new Plugin @, options
