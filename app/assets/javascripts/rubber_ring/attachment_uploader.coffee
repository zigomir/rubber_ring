class @AttachmentUploader

  constructor: (element) ->
    element.dropzone({ url: App.add_attachment_path })
    @addListeners(element)

  addListeners: (element) ->
    dz = Dropzone.forElement(element.get(0))

    # append csfr token before file upload
    dz.on "sending", (file, xhr, form_data) ->
      csrf_param = $('meta[name=csrf-param]').attr('content')
      csrf_token = $('meta[name=csrf-token]').attr('content')
      form_data.append(csrf_param, csrf_token)
      form_data.append('page_controller', App.controller)
      form_data.append('page_action', App.action)
      form_data.append('locale', App.locale)

    dz.on "success", (file, response) ->
      if response.type == "image"
        $(".uploaded-images").append("<img src=\"#{response.src}\" draggable=\"true\" class=\"img-polaroid\" />")
        # append drag listeners to newly uploaded image
        new AttachmentDragger("img[draggable=true]", ".rubber_ring_image", "src")
      else
        $(".uploaded-attachments").append("<a href=\"#{response.src}\" draggable=\"true\" download><i class=\"icon-file\"></i> #{response.src.split('/').reverse()[0]}</a>")
        # append drag listeners to newly uploaded attachment
        new AttachmentDragger("a[draggable=true]", ".rubber_ring_attachment", "href")
