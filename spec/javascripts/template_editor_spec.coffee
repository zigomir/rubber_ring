describe 'TemplateEditor', ->

  it 'should TODO', ->
    loadFixtures('templates.html')

    pm   = new PersistenceManager(config.action_btns)
    util = new Util()
    te   = new TemplateEditor(pm, util)
    te.init()

    $templates = $('[data-template]')

    key = te.get_templates_key($templates)
    templates_to_save = te.get_templates_array($templates)

    expect(key).toBe('template_key')
    expect(templates_to_save.length).toBe(2)

    expect(templates_to_save[0].index).toBe(0)
    expect(templates_to_save[0].template).toBe('article')

    expect(templates_to_save[1].index).toBe(1)
    expect(templates_to_save[1].template).toBe('blog_post')
