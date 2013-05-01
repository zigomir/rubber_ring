$ ->
  # init
  config = {
    action_btns: {
      reset_btn:            '<button class="reset-content"></button>'
      duplicate_btn:        '<button class="duplicate-content"></button>'
      remove_duplicate_btn: '<button class="remove-duplicat"></button>'
    }
    reset_btn_exclusions:   ".duplicable, [data-cms=page_title]"
  }

  $editable_content     = $("[contenteditable]")

  pm = new PersistenceManager(config.action_btns)
  de = new DuplicableEditor(config.action_btns)
  le = new LinkEditor($editable_content)
  de.init()
  le.init()

  # append content editable with buttons
  $("[contenteditable]").not(config.reset_btn_exclusions).append(config.action_btns.reset_btn)
  $("body").on "click", ".reset-content", (e) ->
    $content_to_remove = $(e.currentTarget).parent()
    if window.confirm "Really want to reset content?"
      pm.remove($content_to_remove).then ->
        window.location.reload(true)

  $(".rubber_ring_attachment").click (e) ->
    e.preventDefault()

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
