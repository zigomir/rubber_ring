class @Util

  constructor: ->

  find_duplicated_keys: (data_cms_elements) ->
    duplicats = []
    cms_keys = []

    data_cms_elements.each ->
      cms_keys.push $(this).attr('data-cms')

    cms_keys.sort()

    i = 1
    compare_key = cms_keys[0]

    while i < cms_keys.length
      duplicats.push compare_key if cms_keys[i] is compare_key
      compare_key = cms_keys[i]
      i++

    duplicats

  create_template_field_keys: ->
    $('[template]').each (index, element) ->
      $(element).attr('order', index)
      editable_fields = $(this).find('[data-cms]')

      editable_fields.each ->
        key = $(this).data('cms').split('|')[1]
        $(this).attr('data-cms', "#{index}|#{key}")
