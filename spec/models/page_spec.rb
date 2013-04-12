require 'spec_helper'

describe Page do
  it 'should create new page' do
    page = FactoryGirl.create(:page)
    expect(page.controller).to eq 'test'
    expect(page.action).to eq 'test'
    expect(page.content['key']).to eq 'value'
    expect(Page.all.count).to eq 1
  end

  it 'should create new page with content' do
    page = Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'key' => 'value' }
     })

    expect(Page.all.count).to eq 1
    expect(page.content['key']).to eq 'value'
    expect(page.content['key2']).to eq nil
  end

  it 'should add new key to content if page already exist' do
    FactoryGirl.create(:page)
    page = Page.save_or_update({
      controller: 'test',
      action: 'test',
      content: { 'key2' => 'value2' }
    })

    expect(Page.all.count).to eq 1
    expect(page.content['key']).to eq 'value'
    expect(page.content['key2']).to eq 'value2'
  end

  it 'should not create new page if one already exists' do
    Page.create({controller: 'test', action: 'test', content: {'key' => 'value'}})
    expect(Page.all.count).to eq 1
    expect { Page.create({controller: 'test', action: 'test', content: {'key' => 'value'}}) }.to raise_error
  end

  # TODO implement on front
  describe 'grouping keys for duplicable content' do
    before do
      options = {
        controller: 'test_controller',
        action:     'test_action',
        content: {
          'group_key' => {
            'child_key_1' => 'child_value_1',
            'child_key_2' => 'child_value_2'
          }
        }
      }

      @page = Page.save_or_update(options)
    end

    it 'should have value under grouped key' do
     expect(@page.group_key?('group_key')).to be_true
     expect(@page.group_key?('group_key_fake')).to be_false

     #expect(@page.content['group_key'].keys.length).to eq 2
     expect(@page.times_duplicable_key('group_key')).to eq 2

     expect(@page.content['group_key']['child_key_1']).to eq 'child_value_1'
    end
  end

end
