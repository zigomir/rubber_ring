jasmine.getFixtures().fixturesPath = 'base/spec/javascripts/fixtures/'

describe "HTML sanitization with peristance manager", ->
  it "should be able to sanitize html and get raw content", ->
    loadFixtures('editable_field.html')
    pm = new PersistenceManager(config.action_btns)
    sanitized = pm.sanitize($('h1'))
    expect(sanitized).toBe('Test content')
