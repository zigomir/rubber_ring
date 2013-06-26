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
