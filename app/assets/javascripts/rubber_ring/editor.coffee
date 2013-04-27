$ ->
  # init
  reset_link = '<a class="reset-content"></a>'

  pm = new PersistenceManager([reset_link])
  de = new DuplicableEditor([reset_link])
  de.init()

  $contentEditable = $("[contenteditable]")

  # append content editable with buttons
  $("[contenteditable]").not(".duplicable").append(reset_link)
  $("body").on "click", ".reset-content", (e) ->
    $content_to_remove = $(e.currentTarget).parent()
    if window.confirm "Really want to reset content?"
      pm.remove($content_to_remove).then ->
        window.location.reload(true)

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
