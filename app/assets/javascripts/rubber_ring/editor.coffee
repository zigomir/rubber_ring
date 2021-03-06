$ ->
  util = new Util()
  # first check for any duplicated keys
  duplicates = util.find_duplicated_keys($('[data-cms]'))
  alert "Correct key duplicates: '#{duplicates}'" if duplicates.length > 0

  pm = new PersistenceManager(App.config.action_btns, $(".alert-saved div"))
  te = new TemplateEditor(pm, util)
  te.init()
  te.init_sortable()

  le = new LinkEditor($("[contenteditable]"))
  le.init()

  App.init = ->
    # append reset button to editable contents
    $("[contenteditable]").append(App.config.action_btns.reset_btn)
    $("img[data-cms]").after(App.config.action_btns.reset_img)

    $("body").on "click", ".reset-content", (e) ->
      $content_to_reset = $(e.currentTarget).parent()
      if window.confirm "Really want reset content?"
        pm.remove($content_to_reset).then ->
          window.location.reload(true)

    $("body").on "click", ".reset-image", (e) ->
      $image_to_reset = $(e.currentTarget).prev()
      if window.confirm "Really want reset image?"
        pm.remove($image_to_reset).then ->
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

    $("[contenteditable]").change (e) ->
      $content = $(e.currentTarget)
      pm.save($content)

    # disable enter in single line editor
    $("[contenteditable]").not(".multi-line").keydown (e) ->
      e.preventDefault() if e.keyCode is 13

    # https://developer.mozilla.org/en-US/docs/Rich-Text_Editing_in_Mozilla#Executing%5FCommands
    $("[contenteditable].multi-line").keydown (e) ->
      if e.which == 13
        lineBreak = "<br />"
        end = $(this).text().length == getCaretCharacterOffsetWithin(this)

        if end
          this.insertAdjacentHTML("beforeend", lineBreak)
        else
          document.execCommand("insertHTML", false, lineBreak)

        false

  getCaretCharacterOffsetWithin = (element) ->
    caretOffset = 0
    unless typeof window.getSelection is "undefined"
      range = window.getSelection().getRangeAt(0)
      preCaretRange = range.cloneRange()
      preCaretRange.selectNodeContents element
      preCaretRange.setEnd range.endContainer, range.endOffset
      caretOffset = preCaretRange.toString().length
    else if typeof document.selection isnt "undefined" and document.selection.type isnt "Control"
      textRange = document.selection.createRange()
      preCaretTextRange = document.body.createTextRange()
      preCaretTextRange.moveToElementText element
      preCaretTextRange.setEndPoint "EndToEnd", textRange
      caretOffset = preCaretTextRange.text.length
    caretOffset

  App.init()