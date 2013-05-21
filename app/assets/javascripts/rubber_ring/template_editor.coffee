class @TemplateEditor

  constructor: (@pm, @util) ->

  init: ->
    # save templates to database immediately
    unless ($('[data-cms-template]').data('from-db'))
      @save_all_templates()

    $('.rr-control .add-remove').click (e) =>
      $select = $(e.currentTarget).parents('.rr-control').find('select')
      action = $(e.target).data('action')

      template = $select.val()
      key = $select.data('cms-template')
      add_index = $("[data-cms=#{key}]").find("[data-template=#{template}]:first").data('template-index')
      remove_index = $("[data-cms=#{key}]").find("[data-template=#{template}]:last").data('template-index')

      content = {
        key: key
        template: template
        index: add_index
      }

      if action is 'add'
        @pm.add_template(content).then ->
          window.location.reload(true)
      else
        if add_index isnt remove_index
          content.index = remove_index

          @pm.remove_template(content).then ->
            window.location.reload(true)

  save_all_templates: ->
    $templates = $('[data-template]')
    key = $templates.parents('[data-cms]').first().data('cms')
    templates_to_save = @get_templates_array($templates)
    @pm.save_template(key, templates_to_save)

  get_templates_array: ($templates) ->
    list = []
    $templates.each (index, element) ->
      list.push({
        index:    $(element).data('template-index')
        template: $(element).data('template')
        tclass:   $(element).attr('class')
        element:  $(element).prop('tagName').toLowerCase()
        sort:     index
      })

    list

  init_sortable: ->
    # init sortable and disable it by default
    $('.templates').sortable()
    $('.templates').sortable('disable')

    $('.rr-control [data-action=sort]').click (e) =>
      $btn = $(e.currentTarget)

      if $('.templates').hasClass('ui-sortable-disabled')
        $('.templates').sortable('enable')
        $btn.text('Disable sort')
        $('.templates').children().css('cursor', 'move')
      else
        $('.templates').sortable('disable')
        $btn.text('Enable sort')
        $('.templates').children().css('cursor', 'auto')

    # re initialize order and save
    $('.templates').on 'sortupdate', (event, ui) =>
      @save_all_templates()
