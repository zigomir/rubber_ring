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
