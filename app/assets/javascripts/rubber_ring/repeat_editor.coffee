# TODO: delete meh
class @RepeatEditor

  constructor: (@pm) ->

  init: ->
    $(".rr-control button").click (e) =>
      key = $(e.currentTarget).data("cms")
      action = $(e.currentTarget).data("action")

      $input = $("##{key}")
      val = $input.val()
      new_val = parseInt(val, 10) + if action == "add" then 1 else -1

      if new_val > 0 # disable removing all for now
        $input.val(new_val)
        @pm.save($input).then ->
          window.location.reload(true)
