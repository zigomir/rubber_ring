class @TemplateEditor

  constructor: (@pm, @util) ->

  init: ->
    $('.rr-control .add-remove').click (e) =>
      $select  = $(e.currentTarget).parent().find('select')
      key      = $select.data('cms')
      action   = $(e.target).data('action')
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
      @pm.save_template(key, get_templates_array($templates))

  init_sortable: ->
    $templates = $('.templates')
    # init sortable and disable it by default
    $templates.sortable()
    # TODO uncomment when done
    $templates.sortable('disable')
    $sortable_elements = $templates.children()
    # TODO remove when done
    # $sortable_elements.css('cursor', 'move')

    $('.rr-control [data-action=sort]').click (e) =>
      $btn = $(e.currentTarget)

      if $templates.hasClass('ui-sortable-disabled')
        $templates.sortable('enable')
        $btn.text('Save & disable sort')
        $sortable_elements.css('cursor', 'move')
      else
        $templates.sortable('disable')
        $btn.text('Enable sort')
        $sortable_elements.css('cursor', 'auto')

        key = $(e.currentTarget).parent().parent().find('select').data('cms')
        console.log key
        console.log get_templates_array($('[template]'))
        @pm.save_template(key, get_templates_array($('[template]')))

    # re initialize order
    $templates.on 'sortupdate', (event, ui) ->
      $('.templates').children().each (index, element) ->
        $(element).attr('order', index)

  get_templates_array = ($templates) ->
    templates = []
    $templates.each ->
      templates.push($(this).attr('template'))
    templates