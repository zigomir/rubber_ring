#= require jquery
#= require jquery_ujs

# jQuery start
$ ->
  $contentEditable = $("[contenteditable]")

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
    content = {}
    key = $(e.currentTarget).data("cms")
    htmlValue = $(e.currentTarget).html().trim().replace(/[\r\n]/g, '')
    content[key] = htmlValue

    postObject =
      page_controller: App.controller
      page_action: App.action
      content: content

    console.group "Sending CMS content to server..."
    console.log "'%s' => '%s'", key, htmlValue
    console.groupEnd()
    $.post App.save_path, postObject, (data) ->
      console.log data
      # reload if value was empty - to clear contenteditable br and div tags
      window.location.reload true if postObject.value is ""

  # disable enter in single line editor
  $contentEditable.not(".multi-line").keydown (e) ->
    e.preventDefault()  if e.keyCode is 13
