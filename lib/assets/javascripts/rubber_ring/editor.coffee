#= require jquery
#= require jquery_ujs

# jQuery start
$ ->
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
    save($content)

  save = (content) ->
    post_object =
      page_controller: App.controller
      page_action: App.action
      content: {}

    # it is important to sanitize htmlValue or else we will get more and more broken html from database
    # we need to remove any new lines like \r and \n
    htmlValue = content.html().trim().replace(/[\r\n]/g, '')
    key = content.attr("data-cms") # data wont work here because of cloning dom
    post_object.content[key] = htmlValue

    save_path = App.save_path

    console.group "Sending CMS content to server..."
    console.log post_object
    unless content.attr("data-cms-remove") == null
      console.log "Removing of key %s content", key
      save_path += "?remove=1"

    console.groupEnd()

    $.post save_path, post_object, (data) ->
      console.log data
      # reload if value was empty - to clear contenteditable br and div tags
      window.location.reload true if post_object.value is ""

  # disable enter in single line editor
  $contentEditable.not(".multi-line").keydown (e) ->
    e.preventDefault()  if e.keyCode is 13

  # creating new elements
  # save it as soon it is created so deletition will work also like this
  $duplicables.on "dblclick", (e) ->
    $duplicableField = $(e.currentTarget)
    $parent = $duplicableField.parent()
    # clone with data and events
    $clone = $duplicableField.clone(true).appendTo($parent)

    # TODO extract and test
    temp_key = $clone.data("cms").split("_").reverse()
    temp_key[0] = $(".duplicable").length - 1
    new_key = temp_key.reverse().join("_")
    $clone.attr("data-cms", new_key)
    # save the clone
    save($clone)

  $duplicables.on "click", (e) ->
    if e.which == 2
      e.preventDefault()
      $removingField = $(e.currentTarget)
      key_to_remove = $removingField.attr("data-cms") # jquery .data is doing too much caching to use it here
      $removingField.attr("data-cms-remove", "true")

      # todo remove this log
      console.log key_to_remove

      # save field to remove it from db
      save($removingField)
      $removingField.remove()
