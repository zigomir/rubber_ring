class @DuplicableEditor

  duplicate_link  = '<a class="duplicate-content"></a>'
  remove_duplicat = '<a class="remove-duplicat"></a>'
  links_to_sanitize = [duplicate_link, remove_duplicat]

  first_duplicable_selector = ".duplicable_holder .duplicable:first"
  duplicable_selector       = ".duplicable_holder .duplicable"

  constructor: (@reset_link) ->
    @add_reset_link_to_first_in_duplicable_group()
    links_to_sanitize.push @reset_link
    @pm = new PersistenceManager(links_to_sanitize)

  init: ->
    # only alow to reset first link of duplicables
    $(first_duplicable_selector).append(duplicate_link)
    $("body").on "click", ".duplicate-content", (e) =>
      $content_to_duplicate = $(e.currentTarget).parent()
      @duplicate($content_to_duplicate)

    # only alow to remove non-first of duplicables
    $(duplicable_selector).not(":first").append(remove_duplicat)
    $("body").on "click", ".remove-duplicat", (e) =>
      $duplicat_to_remove = $(e.currentTarget).parent()
      @remove_duplicate($duplicat_to_remove)

  add_reset_link_to_first_in_duplicable_group: ->
    $(first_duplicable_selector).append(@reset_link) if $(duplicable_selector).length == 1

  # creating new elements
  # save it as soon it is created so deletition will work also like this
  duplicate: ($editField) ->
    # save parent first because it is possible that it is not yet saved
    # and we will have problem with counting keys in group
    @pm.save($editField)
    # clone with data and events
    $clone = $editField.clone(true).appendTo($editField.parent())

    new_key = generate_new_group_key($editField)
    $clone.attr("data-cms", new_key)
    # remove some actions from non-first elements
    $(duplicable_selector).not(":first").find(".duplicate-content, .reset-content").remove()
    $(first_duplicable_selector).find(".reset-content").remove()

    $clone.append(remove_duplicat)
    # save the clone
    @pm.save($clone)

  remove_duplicate: ($duplicat) ->
    @pm.remove($duplicat)
    $duplicat.remove()
    @add_reset_link_to_first_in_duplicable_group()

  generate_new_group_key = ($editField) ->
    temp_key = $editField.attr("data-cms").split("_").reverse()
    temp_key[0] = $editField.siblings().length
    new_key = temp_key.reverse().join("_")

    # check if key is already taken
    if $("[data-cms=#{new_key}]").length != 0
      # take the key of last sibling
      temp_key = $editField.siblings().last().attr("data-cms").split("_").reverse()
      temp_key[0] = parseInt(temp_key[0], 10) + 1
      new_key = temp_key.reverse().join("_")

    new_key
