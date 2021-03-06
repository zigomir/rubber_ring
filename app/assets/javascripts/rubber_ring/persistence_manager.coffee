class @PersistenceManager
  post_object:
    page_controller: App.controller
    page_action:     App.action
    page_path:       document.location.pathname
    page_locale:     App.locale

  constructor: (@action_btns, @alert) ->

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

    @post_to_backend(App.save_path, @post_object)

  save_template: (templates) ->
    @post_object.content = templates
    @post_to_backend(App.save_template_path, @post_object)

  add_template: (content) ->
    @post_object.content = content
    @post_to_backend(App.add_template_path, @post_object)

  remove_template: (content) ->
    @post_object.content = content
    @post_to_backend(App.remove_template_path, @post_object)

  save_image: (content) ->
    key = content.attr("data-cms")
    @post_object.content = {}
    @post_object.content[key] = content.attr("src")
    @post_object.width        = content.attr("width")
    @post_object.height       = content.attr("height")
    @post_to_backend(App.save_image_path, @post_object)

  save_attachment: (content) ->
    key = content.attr("data-cms")
    @post_object.content = {}
    @post_object.content[key] = content.attr("href").split('/').reverse()[0]
    @post_object.content["#{key}_href"] = content.attr("href")
    @post_to_backend(App.save_attachment_path, @post_object)

  sanitize: (content) ->
    # it is important to sanitize htmlValue or else we will get more and more broken html from database
    # we need to remove any new lines like \r and \n
    content = content.html().replace(/^[\s]+$/g, "").trim()

    for key, value of @action_btns
      regex = new RegExp(value, "g");
      content = content.replace(regex, "").trim()

    content

  remove: (content) ->
    key = content.attr("data-cms")
    path = App.remove_path.replace(':key', key)
    @post_to_backend(path, @post_object)

  remove_image: (src) ->
    @post_object.src_to_remove = src
    @post_to_backend(App.remove_attachment_path, @post_object)

  post_to_backend: (path, post_object) =>
    $.post path, post_object, =>
      @alert.addClass("animate")
      @alert.on "transitionend", =>
        @alert.removeClass("animate")
