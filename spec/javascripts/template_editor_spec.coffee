describe 'TemplateEditor', ->

  beforeEach ->
    loadFixtures('templates.html')

  it 'should add new template to data attribute', ->
    pm = new PersistenceManager(config.action_btns)
    te = new TemplateEditor(pm)
    te.init()

    # templates = $('select').attr('data-templates')
    templates = $('select').data('templates')
    # console.log templates
    # console.log $('select').data('templates')
    expect(templates.length).toBe(2)
    # console.log templates

    $('[data-action=add]').click()
    # expect(templates).toBe(['blog_post', 'article', 'article'])
    expect(templates.length).toBe(3)

    # console.log $('select').attr('data-templates')