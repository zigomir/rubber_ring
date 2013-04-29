class @PersistenceManager
  save_path: null
  save_image_path: null
  remove_path: null
  remove_image_path: null
  post_object:
    page_controller: App.controller
    page_action: App.action
    page_path: document.location.pathname

  constructor: (@action_btns) ->
    @save_path         = App.save_path
    @save_image_path   = App.save_image_path
    @remove_path       = App.remove_path
    @remove_image_path = App.remove_image_path

  save: (content) ->
    key = content.attr("data-cms") # data wont work here because of cloning dom
    value = @sanitize(content)

    @post_object.content = {}
    @post_object.content[key] = value
    @post_to_backend(@save_path, @post_object)

  save_image: (content) ->
    key = content.attr("data-cms")
    @post_object.content = {}
    @post_object.content[key] = content.attr("src")
    @post_object.width        = content.attr("width")
    @post_object.height       = content.attr("height")
    @post_to_backend(@save_image_path, @post_object)

  # TODO write tests for this method
  sanitize: (content) ->
    # it is important to sanitize htmlValue or else we will get more and more broken html from database
    # we need to remove any new lines like \r and \n
    content = content.html().trim().replace(/[\r\n]/g, '')
    content = content.replace(value, '') for key, value of @action_btns
    content

  remove: (content) ->
    key = content.attr("data-cms")
    path = @remove_path.replace(':key', key)
    @post_object.key_to_remove = key
    @post_to_backend(path, @post_object)

  remove_image: (src) ->
    @post_object.src_to_remove = src
    @post_to_backend(@remove_image_path, @post_object)

  post_to_backend: (path, post_object) ->
    $.post path, post_object
