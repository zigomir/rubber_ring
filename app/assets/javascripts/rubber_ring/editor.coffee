$ ->
  # init
  pm = new PersistenceManager()
  $contentEditable = $("[contenteditable]")
  $duplicables     = $(".duplicable")

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
  $duplicables.on "dblclick", (e) ->
    $editField = $(e.currentTarget)
    # save parent first because it is possible that it is not yet saved
    # and we will have problem with counting keys in group
    pm.save($editField)
    # clone with data and events
    $clone = $editField.clone(true).appendTo($editField.parent())

    new_key = generate_new_group_key($clone)
    $clone.attr("data-cms", new_key)
    # save the clone
    pm.save($clone)

  generate_new_group_key = (element) ->
    temp_key = element.data("cms").split("_").reverse()
    temp_key[0] = $(".duplicable").length - 1
    temp_key.reverse().join("_")

  # removing keys
  $duplicables.on "mouseup", (e) ->
    if e.which == 2 # middle click for removing elements
      e.preventDefault()
      $removingField = $(e.currentTarget)
      pm.remove($removingField)
      $removingField.remove()
