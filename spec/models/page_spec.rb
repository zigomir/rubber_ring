require 'spec_helper'

describe RubberRing::Page do
  it 'should create new page with content' do
    page = RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'key' => 'value' }
     })

    expect(RubberRing::Page.all.count).to eq 1
    expect(page.content['key']).to eq 'value'
    expect(page.content['key2']).to eq nil
  end

  it 'should not create new page if one already exists' do
    RubberRing::Page.create({controller: 'test', action: 'test', content: {'key' => 'value'}})
    expect(RubberRing::Page.all.count).to eq 1
    expect { RubberRing::Page.create({controller: 'test', action: 'test', content: {'key' => 'value'}}) }.to raise_error
  end

  describe 'grouping keys for duplicable content' do
    before do
      options = {
        controller: 'test_controller',
        action:     'test_action',
        content: {
          'child_key_0' => 'child_value_0',
          'child_key_1' => 'child_value_1'
        }
      }

      @page = RubberRing::Page.save_or_update(options)
    end

    it 'should be in a group of two' do
     expect(@page.group_keys('child_key')).to eq %w(child_key_0 child_key_1)
     expect(@page.content['child_key_1']).to eq 'child_value_1'
    end
  end

end
