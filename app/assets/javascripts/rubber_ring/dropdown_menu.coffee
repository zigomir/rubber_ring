$ ->
  $("#rubber-ring-application a.dropdown").on "click", (e) ->
    $link = $(e.currentTarget)
    $("." + $link.attr("id")).slideToggle()
    $link.parent().toggleClass("active")
