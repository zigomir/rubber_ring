describe 'TemplateEditor', ->

  beforeEach ->
    loadFixtures('templates.html')
    pm   = new PersistenceManager(App.config.action_btns)
    util = new Util()
    @te  = new TemplateEditor(pm, util)
    @te.init()

  it 'should build list of templates and their data', ->
    $templates = $('[data-template]')

    templates_to_save = @te.get_templates_array($templates)

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

  it "should save all templates", ->
    spyOn($, "post")
    @te.save_all_templates()

    content = $.post.mostRecentCall.args[1].content

    expect(content[0].index).toBe(0)
    expect(content[0].key).toBe('template_key_1')
    expect(content[0].template).toBe('article')
    expect(content[0].tclass).toBe('t-article')
    expect(content[0].element).toBe('article')

    expect(content[1].index).toBe(1)
    expect(content[1].key).toBe('template_key_1')
    expect(content[1].template).toBe('blog_post')

    expect(content[2].key).toBe('template_key_2')
    expect(content[2].index).toBe(0)
    expect(content[2].template).toBe('article')
