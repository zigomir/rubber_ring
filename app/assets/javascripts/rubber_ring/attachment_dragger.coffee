# r0x http://jsbin.com/uzovu/1357/edit (http://html5doctor.com/native-drag-and-drop/)

class @AttachmentDragger

  constructor: (drag_selector, drop_selector, @attribute) ->
    drag_items = document.querySelectorAll(drag_selector)
    for drag_item in drag_items
      addEvent drag_item, "dragstart", (event) ->
        event.dataTransfer.setData(attribute, $(this).attr(attribute))

    drop_image = document.querySelector(drop_selector)
    # Tells the browser that we *can* drop on this target
    addEvent(drop_image, "dragover", @cancel)
    addEvent(drop_image, "dragenter", @cancel)

    addEvent drop_image, "drop", (e) ->
      # stops the browser from redirecting off to the text
      e.preventDefault() if e.preventDefault

      # this is for chrome so it won't do request if we're trying to drop same image
      if $(this).attr(attribute) != e.dataTransfer.getData(attribute)
        pm = new PersistenceManager()
        this[attribute] = e.dataTransfer.getData(attribute)
        pm.save_image($(this)) if attribute == "src"
        pm.save_attachment($(this)) if attribute == "href"

      false

  cancel: (e) =>
    # this only works correct in FF :/
    e.preventDefault() if e.preventDefault and $(this).attr(@attribute) != e.dataTransfer.getData(@attribute)
    false
