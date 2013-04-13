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

  # it is important to sanitize htmlValue or else we will get more and more broken html from database
  # we need to remove any new lines like \r and \n
  $contentEditable.change (e) ->
    $content = $(e.currentTarget)

    post_object =
      page_controller: App.controller
      page_action: App.action
      content: {}

    key = $content.attr("data-cms") # data wont work here because of cloning dom
    htmlValue = $content.html().trim().replace(/[\r\n]/g, '')
    post_object.content[key] = htmlValue

    console.group "Sending CMS content to server..."
    console.log post_object
    console.groupEnd()

    $.post App.save_path, post_object, (data) ->
      console.log data
      # reload if value was empty - to clear contenteditable br and div tags
      window.location.reload true if post_object.value is ""

  # disable enter in single line editor
  $contentEditable.not(".multi-line").keydown (e) ->
    e.preventDefault()  if e.keyCode is 13


  # creating new elements
  $duplicables.on "dblclick", (e) ->
    $duplicableField = $(e.currentTarget)
    $parent = $duplicableField.parent()
    # clone with data and events
    $clone = $duplicableField.clone(true).appendTo($parent)

    temp_key = $clone.data("cms").split("_").reverse()
    temp_key[0] = $(".duplicable").length - 1
    new_key = temp_key.reverse().join("_")
    $clone.attr("data-cms", new_key)
