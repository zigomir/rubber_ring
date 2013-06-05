$ ->
  # init
  new AttachmentUploader($(".image_upload_box"))
  new AttachmentDragger("img[draggable=true]", ".rubber_ring_image", "src")
  new AttachmentDragger("a[draggable=true]", ".rubber_ring_attachment", "href")

  # remove all unused images action
  $(".remove_not_used_attachments").on "click", ->
    pm = new PersistenceManager(App.config.action_btns, $(".alert-saved div"))
    uploaded_images      = ($(item).attr("src")  for item in $(".uploaded-images img"))
    uploaded_attachments = ($(item).attr("href") for item in $(".uploaded-attachments a"))
    used_images          = ($(item).attr("src")  for item in $(".rubber_ring_image"))
    used_attachments     = ($(item).attr("href") for item in $(".rubber_ring_attachment"))

    for image in uploaded_images
      if image not in used_images
        pm.remove_image(image)
        $(".uploaded-images img[src=\"#{image}\"]").remove()

    for attachment in uploaded_attachments
      if attachment not in used_attachments
        pm.remove_image(attachment)
        $(".uploaded-attachments a[href=\"#{attachment}\"]").remove()
