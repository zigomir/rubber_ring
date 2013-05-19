describe 'Util', ->

  it 'should not find duplicates', ->
    loadFixtures('editable_fields.html')
    util = new Util()
    duplicates = util.find_duplicated_keys($('[data-cms]'))
    expect(duplicates.length).toBe(0)

  it 'should find duplicates', ->
    loadFixtures('duplicate_fields.html')
    util = new Util()
    duplicates = util.find_duplicated_keys($('[data-cms]'))
    expect(duplicates.length).toBe(1)

  it 'should create template keys from order', ->
    loadFixtures('templates.html')
    util = new Util()

    duplicates = util.find_duplicated_keys($('[data-cms]'))
    expect(duplicates.length).toBe(2)

    util.create_template_keys()
    duplicates = util.find_duplicated_keys($('[data-cms]'))
    expect(duplicates.length).toBe(0)

    expect($('[data-cms="3|template_key_article_title"]').length).toBe(1)
    expect($('[data-cms="3|template_key_article_paragraph"]').length).toBe(1)
