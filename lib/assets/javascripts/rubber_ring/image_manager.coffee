$ ->
  # init
  new ImageUploader($(".image_upload_box"))
  new ImageDragger("[draggable=true]", ".rubber_ring_image")

  $("#images-manager").on "click", (e) ->
    $link = $(e.currentTarget)
    $(".images-manager").toggle()
    $link.parent().toggleClass("active")

  # remove all unused images action
  $(".remove_not_used_images").on "click", ->
    pm = new PersistenceManager()
    uploaded_images = ($(item).attr("src") for item in $(".already_uploaded_images img"))
    used_images     = ($(item).attr("src") for item in $(".rubber_ring_image"))

    for uploaded_image in uploaded_images
      if uploaded_image not in used_images
        pm.remove_image(uploaded_image)
        $(".already_uploaded_images img[src=\"#{uploaded_image}\"]").remove()
