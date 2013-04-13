class @ImageUploader

  constructor: (@elements) ->
    @elements.dropzone { url: App.add_image_path }
    @addListeners()

  addListeners: ->
    dz = Dropzone.forElement(@elements.get(0))

    # append csfr token before file upload
    dz.on "sending", (file, xhr, formData) ->
      csrfParam = $('meta[name=csrf-param]').attr('content')
      csrfToken = $('meta[name=csrf-token]').attr('content')
      formData.append(csrfParam, csrfToken)
      formData.append('page_controller', App.controller)
      formData.append('page_action', App.action)

    dz.on "success", (file, response) ->
      $(".already_uploaded_images").append("<img src='#{response.src}' draggable='true' />")
      # append drag listeners to newly uploaded image
      new ImageDragger("[draggable=true]", ".rubber_ring_image")
