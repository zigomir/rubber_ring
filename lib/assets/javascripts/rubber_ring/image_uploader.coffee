class @ImageUploader

  constructor: (@elements) ->
    @elements.dropzone { url: App.add_image_path }
    @listenToOnSend()

  listenToOnSend: ->
    dz = Dropzone.forElement(@elements.get(0))

    # append csfr token before file upload
    dz.on "sending", (file, xhr, formData) ->
      csrfParam = $('meta[name=csrf-param]').attr('content')
      csrfToken = $('meta[name=csrf-token]').attr('content')
      formData.append(csrfParam, csrfToken)
