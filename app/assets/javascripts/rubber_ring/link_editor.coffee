class @LinkEditor

  constructor: (@editable_content) ->

  init: ->
    $edit_link = $("#rubber-ring-application #edit-link")
    @editable_content.bind "click", "a", (e) ->
      $node = $(getSelectionStartNode())
      if $node != null and $node.is("a")
        e.stopPropagation()
        $edit_link.css(
          top: $node.offset().top - $edit_link.height() - 5
          left: $node.offset().left
        ).show()
        $edit_link.data("node", $node)

        $("#link-title").val $node.text()
        $("#link-href").val $node.attr("href")
        $("#link-preview").attr "href", $node.attr("href")
      else
        $edit_link.hide()

    $(document).bind "click", (e) =>
      e.stopPropagation()
      if $("#edit-link").is(":visible") and $(e.target).parents("#edit-link").length == 0
        $edit_link.hide()

    $("#link-title").bind "change", (e) =>
      $node = $edit_link.data("node")
      $node.text $(e.currentTarget).val()
      triggerChange($node)

    $("#link-href").bind "change", (e) =>
      $node = $edit_link.data("node")
      $node.add("#link-preview").attr "href", $(e.currentTarget).val()
      triggerChange($node)

  triggerChange = ($node) ->
    if $node.attr("contenteditable") == "true"
      $node.trigger "change"

  getSelectionStartNode = ->
    if window.getSelection
      node = window.getSelection().anchorNode
      if node != null && node.nodeName is "#text"
      then node.parentNode
      else node
