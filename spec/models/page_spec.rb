require 'spec_helper'

describe RubberRing::Page do
  it 'should create new page with content' do
    page = RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'key' => 'value' }
     })

    RubberRing::Page.all.count.should eq 1
    page.content['key'].should eq 'value'
    page.content['key2'].should eq nil
  end

  it 'should not create new page if one already exists' do
    RubberRing::Page.create({controller: 'test', action: 'test', content: {'key' => 'value'}})
    RubberRing::Page.all.count.should eq 1
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
     @page.group_keys('child_key').should eq %w(child_key_0 child_key_1)
     @page.content['child_key_1'].should eq 'child_value_1'
    end
  end

end
