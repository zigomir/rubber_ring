describe 'TemplateEditor', ->

  it 'should add new template to data attribute', ->
    loadFixtures('templates.html')

    pm   = new PersistenceManager(config.action_btns)
    util = new Util()
    te   = new TemplateEditor(pm, util)
    te.init()

    templates = $('[template]')
    expect(templates.length).toBe(4)

    $('[data-action=add]').click()

    templates = $('[template]')
    expect(templates.length).toBe(5)
