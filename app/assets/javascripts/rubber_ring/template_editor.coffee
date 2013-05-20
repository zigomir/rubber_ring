class @TemplateEditor

  constructor: (@pm, @util) ->

  init: ->
    $('.rr-control .add-remove').click (e) =>
      $select  = $(e.currentTarget).parents('.rr-control').find('select')
      key      = $select.data('cms-template')
      action   = $(e.target).data('action')
      template = $select.val()

      templates_selector      = "[data-cms=#{key}] > *"
      same_templates_selector = ".#{key} [data-template=#{template}]"

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
      $same_templates = $(".#{key} [data-template=#{template}]")

      @util.create_template_field_keys()

      if action is 'add'
        # create object to save
        key = get_templates_key($templates)
        templates_to_save = get_templates_array($templates)
        @pm.save_template(key, templates_to_save)
        # @pm.save_template(key, $templates).then ->
        #   window.reload(true)
      else
        @pm.remove_template(get_templates_key($templates)).then ->
          window.reload(true)

  get_templates_array = ($templates) ->
    list = []
    $templates.each (index, element) ->
      list.push {
        index:    $(element).data('template-index'),
        template: $(element).data('template')
      }

    list

  get_templates_key = ($templates) ->
    $templates.parents('[data-cms]').first().data('cms')

  init_sortable: ->
    # init sortable and disable it by default
    # $('.templates').sortable()
    # $('.templates').sortable('disable')

    # $('.rr-control [data-action=sort]').click (e) =>
    #   $btn = $(e.currentTarget)

    #   if $('.templates').hasClass('ui-sortable-disabled')
    #     $('.templates').sortable('enable')
    #     $btn.text('Disable sort')
    #     $('.templates').children().css('cursor', 'move')
    #   else
    #     $('.templates').sortable('disable')
    #     $btn.text('Enable sort')
    #     $('.templates').children().css('cursor', 'auto')

    #     # @pm.save_template(key, get_templates_array($('[template]')))

    # # re initialize order and save
    # $('.templates').on 'sortupdate', (event, ui) =>
    #   $('.templates').children().each (index, element) =>
    #     $(element).attr('order', index)

    #   # get_templates_array($('[template]'))
    #   key = $(event.currentTarget).prev('.rr-control').find('select').data('cms')
    #   @pm.save_template(key, get_templates_array($('[template]')))

  # get_templates_array = ($templates) ->
  #   templates = []
  #   $templates.each (index, element) ->
  #     # TODO better tests
  #     # read index from children cms keys
  #     # if no index could be foind, just add index from order
  #     if $(element).find('[data-cms]').length > 0
  #       i = $(element).find('[data-cms]').first().data('cms').split('|')[0]
  #     else
  #       i   = index

  #     key = "#{i}|#{$(element).attr('template')}"
  #     templates.push(key)

  #   console.log templates
  #   templates