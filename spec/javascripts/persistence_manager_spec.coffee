describe "Peristance Manager", ->

  beforeEach ->
    loadFixtures('editable_fields.html')
    @pm = new PersistenceManager(config.action_btns)

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
