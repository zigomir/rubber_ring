describe 'TemplateEditor', ->

  it 'should build list of templates and their data', ->
    loadFixtures('templates.html')

    pm   = new PersistenceManager(config.action_btns)
    util = new Util()
    te   = new TemplateEditor(pm, util)
    te.init()

    $templates = $('[data-template]')

    templates_to_save = te.get_templates_array($templates)

    expect(templates_to_save.length).toBe(3)

    expect(templates_to_save[0].index).toBe(0)
    expect(templates_to_save[0].key).toBe('template_key_1')
    expect(templates_to_save[0].template).toBe('article')
    expect(templates_to_save[0].tclass).toBe('t-article')
    expect(templates_to_save[0].element).toBe('article')

    expect(templates_to_save[1].index).toBe(1)
    expect(templates_to_save[1].key).toBe('template_key_1')
    expect(templates_to_save[1].template).toBe('blog_post')

    expect(templates_to_save[2].key).toBe('template_key_2')
    expect(templates_to_save[2].index).toBe(0)
    expect(templates_to_save[2].template).toBe('article')
