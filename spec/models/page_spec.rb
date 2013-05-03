require 'spec_helper'

describe RubberRing::Page do
  it 'should create new page with content' do
    page = RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'cms_key' => 'cms_value' }
     })

    RubberRing::Page.all.count.should eq 1
    RubberRing::PageContent.all.count.should eq 1

    page.content['cms_key'].should eq 'cms_value'
    page.content['key2'].should eq nil
  end

  it 'should update page content' do
    RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'cms_key' => 'cms_value' }
     })

    RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'cms_key' => 'cms_value_new' }
     })

    RubberRing::Page.all.count.should eq 1
    RubberRing::PageContent.all.count.should eq 1

    # we need to reload page to fetch all page contents
    page = RubberRing::Page.first
    page.content['cms_key'].should eq 'cms_value_new'
  end

  it 'should add page content' do
    RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'cms_key' => 'cms_value' }
     })

    RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       content: { 'cms_key_new' => 'cms_value_new' }
     })

    RubberRing::Page.all.count.should eq 1
    RubberRing::PageContent.all.count.should eq 2

    # we need to reload page to fetch all page contents
    page = RubberRing::Page.first
    page.content['cms_key'].should eq 'cms_value'
    page.content['cms_key_new'].should eq 'cms_value_new'
  end


  it 'should remove right page content' do
    RubberRing::Page.save_or_update({
      controller: 'test',
      action: 'test',
      content: { 'cms_key' => 'cms_value' }
    })

    RubberRing::Page.save_or_update({
      controller: 'test',
      action: 'test',
      content: { 'cms_key_new' => 'cms_value_new' }
    })

    RubberRing::PageContent.all.count.should eq 2

    RubberRing::Page.remove({
       controller: 'test',
       action: 'test',
       content: {}
     }, 'cms_key')

    RubberRing::Page.all.count.should eq 1
    RubberRing::PageContent.all.count.should eq 1

    page = RubberRing::Page.first
    page.content['cms_key_new'].should eq 'cms_value_new'
  end

  describe 'grouping keys for duplicable content' do
    before do
      child1 = {
        controller: 'test_controller',
        action:     'test_action',
        content: {
          'child_key_0' => 'child_value_0'
        }
      }

      child2 = {
        controller: 'test_controller',
        action:     'test_action',
        content: {
          'child_key_1' => 'child_value_1'
        }
      }

      RubberRing::Page.save_or_update(child1)
      RubberRing::Page.save_or_update(child2)
    end

    it 'should be in a group of two' do
      page = RubberRing::Page.first
      page.group_keys('child_key').should eq %w(child_key_0 child_key_1)
      page.content['child_key_0'].should eq 'child_value_0'
      page.content['child_key_1'].should eq 'child_value_1'
    end
  end
end
