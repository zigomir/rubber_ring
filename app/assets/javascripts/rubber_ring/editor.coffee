$ ->
  # init
  reset_link      = '<a class="reset-content"></a>'
  duplicate_link  = '<a class="duplicate-content"></a>'
  remove_duplicat = '<a class="remove-duplicat"></a>'
  links_to_sanitize = [reset_link, duplicate_link, remove_duplicat]

  pm = new PersistenceManager(links_to_sanitize)
  $contentEditable = $("[contenteditable]")

  add_reset_link_to_first_in_duplicable_group = () ->
    $(".duplicable_holder .duplicable:first").append(reset_link) if $(".duplicable_holder .duplicable").length == 1

  # append content editable with buttons
  $("[contenteditable]").not(".duplicable").append(reset_link)
  add_reset_link_to_first_in_duplicable_group()
  $("body").on "click", ".reset-content", (e) ->
    $content_to_remove = $(e.currentTarget).parent()
    if window.confirm "Really want to reset content?"
      pm.remove($content_to_remove).then ->
        window.location.reload(true)

  # only alow to reset first link of duplicables
  $(".duplicable:first").append(duplicate_link)
  $("body").on "click", ".duplicate-content", (e) ->
    $content_to_duplicate = $(e.currentTarget).parent()
    duplicate($content_to_duplicate)

  # only alow to remove non-first of duplicables
  $(".duplicable_holder .duplicable").not(":first").append(remove_duplicat)
  $("body").on "click", ".remove-duplicat", (e) ->
    $duplicat_to_remove = $(e.currentTarget).parent()
    duplicat_to_remove($duplicat_to_remove)

  # register change event for HTML5 content editable
  $("body").on "focus", "[contenteditable]", ->
    $this = $(this)
    $this.data "before", $this.html()
    $this
  .on "blur", "[contenteditable]", ->
    $this = $(this)
    if $this.data("before") isnt $this.html()
      $this.data "before", $this.html()
      $this.trigger "change"
    $this

  $contentEditable.change (e) ->
    $content = $(e.currentTarget)
    pm.save($content)

  # disable enter in single line editor
  $contentEditable.not(".multi-line").keydown (e) ->
    e.preventDefault()  if e.keyCode is 13

  # creating new elements
  # save it as soon it is created so deletition will work also like this
  duplicate = ($editField) ->
    # save parent first because it is possible that it is not yet saved
    # and we will have problem with counting keys in group
    pm.save($editField)
    # clone with data and events
    $clone = $editField.clone(true).appendTo($editField.parent())

    new_key = generate_new_group_key($editField)
    $clone.attr("data-cms", new_key)
    # remove some actions from non-first elements
    $(".duplicable_holder .duplicable").not(":first").find(".duplicate-content, .reset-content").remove()
    $(".duplicable_holder .duplicable:first").find(".reset-content").remove()

    $clone.append(remove_duplicat)
    # save the clone
    pm.save($clone)

  duplicat_to_remove = ($duplicat) ->
    pm.remove($duplicat)
    $duplicat.remove()
    add_reset_link_to_first_in_duplicable_group()

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
