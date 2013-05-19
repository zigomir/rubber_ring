class @PersistenceManager
  save_path:              null
  remove_path:            null

  save_image_path:        null
  save_attachment_path:   null
  remove_attachment_path: null

  $alert:                 null

  post_object:
    page_controller: App.controller
    page_action:     App.action
    page_path:       document.location.pathname
    page_locale:     App.locale

  constructor: (@action_btns) ->
    @save_path              = App.save_path
    @save_image_path        = App.save_image_path
    @save_attachment_path   = App.save_attachment_path
    @remove_path            = App.remove_path
    @remove_attachment_path = App.remove_attachment_path
    @$alert                 = $(".alert-saved div")

    @$alert.bind 'transitionend webkitTransitionEnd', =>
      @$alert.removeClass("show")

  save: (content) ->
    key = content.attr("data-cms") # data wont work here because of cloning dom

    if content.is('input')
      value = content.val()
    else
      value = @sanitize(content)

    @post_object.content = {}
    @post_object.content[key] = value

    if content.is("a")
      @post_object.content["#{key}_href"] = content.attr("href")

    @post_to_backend(@save_path, @post_object)

  save_template: (key, content) ->
    @post_object.content = {}
    @post_object.content[key] = content
    @post_to_backend(@save_path, @post_object)

  save_image: (content) ->
    key = content.attr("data-cms")
    @post_object.content = {}
    @post_object.content[key] = content.attr("src")
    @post_object.width        = content.attr("width")
    @post_object.height       = content.attr("height")
    @post_to_backend(@save_image_path, @post_object)

  save_attachment: (content) ->
    key = content.attr("data-cms")
    @post_object.content = {}
    @post_object.content[key]           = content.attr("href").split('/').reverse()[0]
    @post_object.content["#{key}_href"] = content.attr("href")
    @post_to_backend(@save_attachment_path, @post_object)

  sanitize: (content) ->
    # it is important to sanitize htmlValue or else we will get more and more broken html from database
    # we need to remove any new lines like \r and \n
    content = content.html().replace(/^[\s]+$/g, "").trim()
    content = content.replace(value, "").trim() for key, value of @action_btns
    content

  remove: (content) ->
    key = content.attr("data-cms")
    path = @remove_path.replace(':key', key)
    @post_to_backend(path, @post_object)

  remove_image: (src) ->
    @post_object.src_to_remove = src
    @post_to_backend(@remove_attachment_path, @post_object)

  post_to_backend: (path, post_object) =>
    $.post path, post_object, =>
      @$alert.addClass("show")
