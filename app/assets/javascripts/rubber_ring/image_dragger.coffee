# r0x http://jsbin.com/uzovu/1357/edit (http://html5doctor.com/native-drag-and-drop/)

class @ImageDragger

  constructor: (drag_selector, drop_selector) ->
    drag_items = document.querySelectorAll(drag_selector)
    for drag_item in drag_items
      addEvent drag_item, "dragstart", (event) ->
        event.dataTransfer.setData("src", $(this).attr("src"))

    drop_image = document.querySelector(drop_selector)
    # Tells the browser that we *can* drop on this target
    addEvent(drop_image, "dragover", @cancel)
    addEvent(drop_image, "dragenter", @cancel)

    addEvent drop_image, "drop", (e) ->
      # stops the browser from redirecting off to the text
      e.preventDefault() if e.preventDefault

      # this is for chrome so it won't do request if we're trying to drop same image
      if $(this).attr("src") != e.dataTransfer.getData("src")
        pm = new PersistenceManager()
        this.src = e.dataTransfer.getData("src")
        pm.save($(this))

      false

  cancel: (e) ->
    # this only works correct in FF :/
    e.preventDefault() if e.preventDefault and $(this).attr("src") != e.dataTransfer.getData("src")
    false
