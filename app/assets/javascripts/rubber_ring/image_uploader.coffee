class @ImageUploader

  constructor: (element) ->
    element.dropzone({ url: App.add_attachment_path })
    @addListeners(element)

  addListeners: (element) ->
    dz = Dropzone.forElement(element.get(0))

    # append csfr token before file upload
    dz.on "sending", (file, xhr, formData) ->
      csrfParam = $('meta[name=csrf-param]').attr('content')
      csrfToken = $('meta[name=csrf-token]').attr('content')
      formData.append(csrfParam, csrfToken)
      formData.append('page_controller', App.controller)
      formData.append('page_action', App.action)

    dz.on "success", (file, response) ->
      if response.type == "image"
        $(".uploaded-images").append("<img src='#{response.src}' draggable='true' class='img-polaroid' />")
        # append drag listeners to newly uploaded image
        new AttachmentDragger("[draggable=true]", ".rubber_ring_image", "src")
      else
        $(".uploaded-attachments").append("<a href='#{response.src}' draggable='true' download>#{response.src.split('/').reverse()[0]}</a>")
        # append drag listeners to newly uploaded attachment
        new AttachmentDragger("[draggable=true]", ".rubber_ring_attachment", "href")
