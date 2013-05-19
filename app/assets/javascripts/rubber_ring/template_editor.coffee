class @TemplateEditor

  constructor: (@pm) ->

  init: ->
    $('.rr-control button').click (e) =>
      $select = $('select')
      key     = $select.data('cms')
      content = $select.data('templates')
      action  = $(e.currentTarget).data('action')

      if action is 'add'
        content.push($select.val())
      else
        i = content.indexOf($select.val())
        content.splice(i, 1)

      # console.log content
      # $select.data(content)
      console.log $select.data('templates')

      # $select.attr('data-templates', content)
      console.log $select.attr('data-templates')
      # @pm.save_template(key, content).then ->
        # window.location.reload(true)
