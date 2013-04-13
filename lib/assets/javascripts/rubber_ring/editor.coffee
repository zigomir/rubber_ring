#= require jquery
#= require jquery_ujs
#= require dropzone
#= require h5utils
#= require ./image_uploader
#= require ./image_dragger

# jQuery start
$ ->
  # init
  $contentEditable = $("[contenteditable]")
  $duplicables     = $(".duplicable")
  new ImageUploader($(".image_upload_box"))
  new ImageDragger("[draggable=true]", ".rubber_ring_image")

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

    path = App.save_path

    console.log "Sending CMS content to server..."
    console.log post_object
    if content.attr("data-cms-remove")
      console.log "Removing of key %s content", key
      path = App.remove_path.replace(':key', key)

    $.post path, post_object, (data) ->
      console.log data
      # reload if value was empty - to clear contenteditable br and div tags
      window.location.reload true if post_object.value is ""

  # disable enter in single line editor
  $contentEditable.not(".multi-line").keydown (e) ->
    e.preventDefault()  if e.keyCode is 13

  # creating new elements
  # save it as soon it is created so deletition will work also like this
  $duplicables.on "dblclick", (e) ->
    $editField = $(e.currentTarget)
    # save parent first because it is possible that it is not yet saved
    # and we will have problem with counting keys in group
    save($editField)
    # clone with data and events
    $clone = $editField.clone(true).appendTo($editField.parent())

    new_key = generate_new_group_key($clone)
    $clone.attr("data-cms", new_key)
    # save the clone
    save($clone)

  generate_new_group_key = (element) ->
    temp_key = element.data("cms").split("_").reverse()
    temp_key[0] = $(".duplicable").length - 1
    temp_key.reverse().join("_")

  $duplicables.on "mouseup", (e) ->
    if e.which == 2 # middle click for removing elements
      e.preventDefault()
      $removingField = $(e.currentTarget)
      $removingField.attr("data-cms-remove", "true")

      # save field to remove it from db
      save($removingField)
      $removingField.remove()
