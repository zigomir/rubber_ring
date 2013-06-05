describe "Peristance Manager", ->

  beforeEach ->
    loadFixtures('editable_fields.html')
    @pm = new PersistenceManager(App.config.action_btns)

  it "should be able to sanitize html and get raw content", ->
    sanitized = @pm.sanitize($('h1'))
    expect(sanitized).toBe('Test content<p>Paragraph</p>')

  it "should save right content and key", ->
    spyOn($, "post")
    @pm.save($('a'))

    content = $.post.mostRecentCall.args[1].content
    expect(content.link).toBe('Link')
    expect(content.link_href).toBe('/link')

  it "should save image", ->
    spyOn($, "post")
    @pm.save_image($('img'))

    content = $.post.mostRecentCall.args[1].content
    width = $.post.mostRecentCall.args[1].width
    height = $.post.mostRecentCall.args[1].height

    expect(content.image).toBe('/assets/baws.jpg')
    expect(height).toBe('360')
    expect(width).toBe('120')

  it "should remove image", ->
    spyOn($, "post")
    @pm.remove_image($('img').attr("src"))

    post_object = $.post.mostRecentCall.args[1]
    expect(post_object.src_to_remove).toBe('/assets/baws.jpg')

  it "should remove/reset content", ->
    spyOn($, "post")
    @pm.remove($("a"))

    path = $.post.mostRecentCall.args[0]
    expect(path).toBe('cms/remove/link')

  it "should save attachment", ->
    spyOn($, "post")
    @pm.save_attachment($(".rubber_ring_attachment"))

    content = $.post.mostRecentCall.args[1].content

    expect(content.attachment_key).toBe('file.pdf')
    expect(content.attachment_key_href).toBe('http://www.example.com/file.pdf')

  it "should add template", ->
    spyOn($, "post")
    template = {
      key: 'key'
      template: 'template'
      index: '13'
    }
    @pm.add_template(template)

    content = $.post.mostRecentCall.args[1].content
    expect(content.key).toBe('key')
    expect(content.template).toBe('template')
    expect(content.index).toBe('13')

  it "should remove template", ->
    spyOn($, "post")
    template = {
      key: 'key'
      template: 'template'
      index: '23'
    }
    @pm.remove_template(template)

    content = $.post.mostRecentCall.args[1].content
    expect(content.key).toBe('key')
    expect(content.template).toBe('template')
    expect(content.index).toBe('23')
