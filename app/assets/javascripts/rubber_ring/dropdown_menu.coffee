$ ->
  $("#rubber-ring-application a.dropdown").click (e) ->
    $link = $(e.currentTarget)
    # clean other activated sections
    class_to_hide = $link.parent().siblings(".active").toggleClass()
      .find("a").attr("id")
    $(".#{class_to_hide}").slideToggle()

    $(".#{$link.attr('id')}").slideToggle()
    $link.parent().toggleClass("active")
