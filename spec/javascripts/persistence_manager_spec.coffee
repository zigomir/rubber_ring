describe "Peristance Manager", ->

  beforeEach ->
    loadFixtures('editable_fields.html')

  it "should be able to sanitize html and get raw content", ->
    pm = new PersistenceManager(config.action_btns)
    sanitized = pm.sanitize($('h1'))
    expect(sanitized).toBe('Test content<p>Paragraph</p>')

  it "should post right content and key", ->
    spyOn($, "post")
    pm = new PersistenceManager(config.action_btns)
    pm.save($('a'))

    content = $.post.mostRecentCall.args[1].content
    expect(content.link).toBe('Link')
    expect(content.link_href).toBe('/link')
