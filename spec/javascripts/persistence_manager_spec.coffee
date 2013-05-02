describe "Peristance Manager", ->

  beforeEach ->
    loadFixtures('editable_fields.html')

  it "should be able to sanitize html and get raw content", ->
    pm = new PersistenceManager(config.action_btns)
    sanitized = pm.sanitize($('h1'))
    expect(sanitized).toBe('Test content')

  it "should show alert-saved on saving", ->
    expect($(".alert-saved div").hasClass("show")).toBe(false)
    pm = new PersistenceManager(config.action_btns)
    pm.save($('h1')).then ->
      expect($(".alert-saved div").hasClass("show")).toBe(true)
