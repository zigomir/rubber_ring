$ ->
  # init
  reset_link            = '<a class="reset-content"></a>'
  duplicate_link        = '<a class="duplicate-content"></a>'
  remove_duplicate_link = '<a class="remove-duplicat"></a>'
  links_to_sanitize     = [duplicate_link, remove_duplicate_link, reset_link]

  pm = new PersistenceManager(links_to_sanitize)
  de = new DuplicableEditor(duplicate_link, remove_duplicate_link, reset_link)
  de.init()

  $editable_content = $("[contenteditable]")

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

  $editable_content.change (e) ->
    $content = $(e.currentTarget)
    pm.save($content)

  # disable enter in single line editor
  $editable_content.not(".multi-line").keydown (e) ->
    e.preventDefault()  if e.keyCode is 13
