class @PersistenceManager
  content: null
  save_path: null
  remove_path: null
  post_object:
    page_controller: App.controller
    page_action: App.action

  constructor: ->
    @save_path   = App.save_path
    @remove_path = App.remove_path

  save: (content) ->
    tag = content.context.localName
    key = content.attr("data-cms") # data wont work here because of cloning dom
    # it is important to sanitize htmlValue or else we will get more and more broken html from database
    # we need to remove any new lines like \r and \n
    value = content.html().trim().replace(/[\r\n]/g, '')
    value = content.attr("src") if tag is 'img'

    @post_object.content = {}
    @post_object.content[key] = value
    path = @save_path

    console.log "Sending CMS content to server..."
    console.log @post_object

    @post_to_backend(path, @post_object)

  remove: (content) ->
    key = content.attr("data-cms")
    console.log "Removing of key %s content", key

    path = @remove_path.replace(':key', key)
    @post_object.key_to_remove = key

    @post_to_backend(path, @post_object)

  post_to_backend: (path, post_object) ->
    $.post path, post_object, (data) ->
      console.log data
