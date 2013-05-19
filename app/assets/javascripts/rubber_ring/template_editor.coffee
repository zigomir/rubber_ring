class @TemplateEditor

  constructor: (@pm, @util) ->

  init: ->
    $('.rr-control button').click (e) =>
      $select  = $('select')
      key      = $select.data('cms')
      action   = $(e.currentTarget).data('action')
      template = $select.val()

      templates_selector      = ".#{key} > *"
      same_templates_selector = ".#{key} [template=#{template}]"

      $templates      = $(templates_selector)
      $same_templates = $(same_templates_selector)
      $parent         = $templates.first().parent()

      # prevent removing last one
      if $same_templates.length is 1 and action is 'remove'
        return

      if action is 'add'
        $same_templates.first().clone(true).appendTo($parent)
      else
        $same_templates.last().remove()

      # refresh templates arrays
      $templates      = $(templates_selector)
      $same_templates = $(".#{key} [template=#{template}]")

      @util.create_template_keys()

      templates = []
      $templates.each ->
        templates.push($(this).attr('template'))

      @pm.save_template(key, templates)