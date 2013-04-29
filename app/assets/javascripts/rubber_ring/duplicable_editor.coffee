class @DuplicableEditor

  constructor: (@action_btns) ->
    @add_reset_btn_to_first_in_duplicable_group(null)
    @pm = new PersistenceManager(action_btns)

  init: ->
    # only alow to reset first link of duplicables
    $(".duplicable_holder").find(".duplicable:first").append(@action_btns.duplicate_btn)
    $("body").on "click", ".duplicate-content", (e) =>
      $content_to_duplicate = $(e.currentTarget).parent()
      @duplicate($content_to_duplicate)

    # only alow to remove non-first of duplicables
    $(".duplicable_holder").find(".duplicable:first").siblings().append(@action_btns.remove_duplicate_btn)
    $("body").on "click", ".remove-duplicat", (e) =>
      $duplicat_to_remove = $(e.currentTarget).parent()
      @remove_duplicate($duplicat_to_remove)

  add_reset_btn_to_first_in_duplicable_group: ($duplicat) ->
    if $duplicat is null
      $(".duplicable_holder").find(".duplicable:first").each (index, element) =>
        $(element).append(@action_btns.reset_btn) if $(element).siblings().length == 0
    else
      # only one which we are currently removing
      $duplicat.append(@action_btns.reset_btn) if $duplicat.siblings().length == 1

  # creating new elements
  duplicate: ($editField) ->
    # save parent first because it is possible that it is not yet saved
    # and we will have problem with counting keys in group
    @pm.save($editField)
    # clone with data and events
    $clone = $editField.clone(true).appendTo($editField.parent())

    new_key = generate_new_group_key($editField)
    $clone.attr("data-cms", new_key)
    # remove some actions from non-first elements
    $editField.parent().children().not(":first").find(".duplicate-content, .reset-content").remove()
    $editField.find(".reset-content").remove()

    $clone.append(@action_btns.remove_duplicate_btn)
    # save the clone
    @pm.save($clone)

  remove_duplicate: ($duplicat) ->
    @pm.remove($duplicat)
    @add_reset_btn_to_first_in_duplicable_group($duplicat.siblings().first())
    $duplicat.remove()

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
