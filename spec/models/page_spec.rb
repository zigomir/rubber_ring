require 'spec_helper'

describe RubberRing::Page do
  it 'should create new page with content' do
    RubberRing::Page.save_or_update({
       controller: 'test',
       action: 'test',
       locale: 'en',
       content: { 'cms_key' => 'cms_value' }
     })

    RubberRing::Page.all.count.should eq 1
    RubberRing::PageContent.all.count.should eq 1

    page = RubberRing::Page.first
    page.content['cms_key'].should eq 'cms_value'
    page.content['key2'].should eq nil
    page.locale.should eq 'en'
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
     },
     'cms_key'
    )

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

  describe 'page templates' do
    before do
      RubberRing::Page.save_or_update_templates({
        controller: 'test',
        action: 'test',
        locale: 'en',
        content: {
          '0' => {
            'key'      => 'template_key',
            'index'    => 1,
            'template' => 'article',
            'sort'     => 1,
            'tclass'   => 'article_class',
            'element'  => 'article'
          },
          '1' => {
            'key'      => 'template_key',
            'index'    => 2,
            'template' => 'blog_post',
            'sort'     => 2,
            'tclass'   => 'blog_post_class',
            'element'  => 'div'
          }
        }
       })
    end

    it 'should create page templates' do
      RubberRing::Page.all.count.should eq 1
      RubberRing::PageContent.all.count.should eq 0
      RubberRing::PageTemplate.all.count.should eq 2

      page = RubberRing::Page.first
      page.page_templates[0].template.should eq 'article'
      page.page_templates[0].id.should eq 1
      page.page_templates[0].sort.should eq 1
      page.page_templates[0].tclass.should eq 'article_class'
      page.page_templates[0].element.should eq 'article'

      page.page_templates[1].template.should eq 'blog_post'
      page.page_templates[1].id.should eq 2
      page.page_templates[1].sort.should eq 2
      page.page_templates[1].tclass.should eq 'blog_post_class'
      page.page_templates[1].element.should eq 'div'
    end

    it 'should update page templates sort' do
      RubberRing::Page.save_or_update_templates({
        controller: 'test',
        action: 'test',
        locale: 'en',
        content: {
          '0' => {
            'key'      => 'template_key',
            'template' => 'article',
            'index'    => 2,
            'sort'     => 123,
            'tclass'   => 'a',
            'element'  => 'b'
          }
        }
       })

      RubberRing::Page.all.count.should eq 1
      RubberRing::PageTemplate.all.count.should eq 2

      page_template = RubberRing::PageTemplate.find(2)
      page_template.sort.should eq 123
    end
  end

end
