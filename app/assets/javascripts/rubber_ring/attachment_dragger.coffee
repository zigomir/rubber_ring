# r0x http://jsbin.com/uzovu/1357/edit (http://html5doctor.com/native-drag-and-drop/)

class @AttachmentDragger

  attribute: null
  drag_items: null

  constructor: (@drag_selector, @drop_selector, @attribute) ->
    @init()

  init: =>
    @drag_items = document.querySelectorAll(@drag_selector)
    for drag_item in @drag_items
      addEvent drag_item, "dragstart", (e) =>
        event.dataTransfer.setData(@attribute, $(e.currentTarget).attr(@attribute))

    drop_attachment_element = document.querySelector(@drop_selector)
    # Tells the browser that we *can* drop on this target
    addEvent(drop_attachment_element, "dragover", @cancel)
    addEvent(drop_attachment_element, "dragenter", @cancel)

    addEvent drop_attachment_element, "drop", (e) =>
      # stops the browser from redirecting off to the text
      e.preventDefault() if e.preventDefault

      # this is for chrome so it won't do request if we're trying to drop same image
      if $(e.currentTarget).attr(@attribute) != e.dataTransfer.getData(@attribute)
        new_content = e.dataTransfer.getData(@attribute)

        # prevent dropping images on attachments and vice versa
        if new_content.length > 0
          $(e.currentTarget).attr(@attribute, e.dataTransfer.getData(@attribute))
          # also change link if we are dropping attachmeng
          $(e.currentTarget).html(e.dataTransfer.getData(@attribute).split('/').reverse()[0]) if @attribute == "href"

          pm = new PersistenceManager()
          pm.save_image($(e.currentTarget)) if @attribute == "src"
          pm.save_attachment($(e.currentTarget)) if @attribute == "href"

      false

  cancel: (e) =>
    # this only works correct in FF :/
    e.preventDefault() if e.preventDefault and $(e.currentTarget).attr(@attribute) != e.dataTransfer.getData(@attribute)
    false
