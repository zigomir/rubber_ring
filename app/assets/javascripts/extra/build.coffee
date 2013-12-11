$ ->
  check = ->
    $.get App.check_build_finished_path, (buildFinished) ->

      if buildFinished
        window.clearInterval(intervalId)
        $('.tbs').removeClass('hide')
        $('.tbs.loading').addClass('hide')

  intervalId = window.setInterval(check, 500)
