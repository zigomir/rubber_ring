require 'spec_helper'

describe RubberRing::CmsController do
  before(:each) { @routes = RubberRing::Engine.routes }

  it 'should save content for the page' do
    xhr :post, :save, {
      page_controller: 'test',
      page_action: 'test',
      page_locale: 'fr',
      content: { 'key' => 'value' }
    }
    response.should be_success

    RubberRing::Page.all.size.should eq 1
    RubberRing::PageContent.all.size.should eq 1
    RubberRing::Page.first.locale.should eq 'fr'
  end

  it 'should save multiple keys' do
    xhr :post, :save, {
      page_controller: 'test',
      page_action: 'test',
      content: { 'key1' => 'value1', 'key2' => 'value2' }
    }
    response.should be_success

    RubberRing::Page.all.size.should eq 1
    RubberRing::PageContent.all.size.should eq 2
    RubberRing::Page.first.locale.should eq 'en'
  end

  it 'should remove key from pages content' do
    # create content with key = "key"
    xhr :post, :save, {
      page_controller: 'test',
      page_action: 'test',
      content: { 'key' => 'value' }
    }
    # try to remove this key from content
    xhr :post, :remove, {
      key: 'key',
      page_controller: 'test',
      page_action: 'test',
    }

    RubberRing::Page.all.size.should eq 1
    RubberRing::PageContent.all.size.should eq 0

    response.should be_success
  end

  describe 'templates' do
    before do
      xhr :post, :save_template, {
        page_controller: 'test',
        page_action: 'test',
        page_locale: 'en',
        content: {
          '0' => {
            'key'      => 'template_key',
            'index'    => 0,
            'template' => 'article',
            'sort'     => 1,
            'tclass'   => 'article_class',
            'element'  => 'article'
          }
        }
      }
      response.should be_success

      RubberRing::Page.all.size.should eq 1
      RubberRing::PageContent.all.size.should eq 0
      RubberRing::PageTemplate.all.size.should eq 1
    end

    it 'should save templates for the page' do
      page = RubberRing::Page.first
      page.page_templates[0].template.should eq 'article'
      page.page_templates[0].id.should eq 1
      page.page_templates[0].sort.should eq 1
      page.page_templates[0].tclass.should eq 'article_class'
      page.page_templates[0].element.should eq 'article'

      xhr :post, :save_template, {
        page_controller: 'test',
        page_action: 'test',
        page_locale: 'en',
        content: {
          '0' => {
            'key'      => 'template_key_1',
            'index'    => 2,
            'sort'     => 1,
            'template' => 'a',
            'tclass'   => 'a',
            'element'  => 'b'
          },
          '1' => {
            'key'      => 'template_key_1',
            'index'    => 3,
            'sort'     => 123,
            'template' => 'a',
            'tclass'   => 'a',
            'element'  => 'b'
          }
        }
      }

      page_template = RubberRing::PageTemplate.last
      page_template.id.should eq 3
      page_template.sort.should eq 123
    end

    it 'should create new template instance' do
      # content of this post request tells which
      # template we want to duplicate
      xhr :post, :add_template, {
        page_controller: 'test',
        page_action: 'test',
        page_locale: 'en',
        content: {
          'key'      => 'template_key',
          'template' => 'article',
          'index'    => 0,
        }
      }

      RubberRing::PageTemplate.all.size.should eq 2
      page_template = RubberRing::PageTemplate.last
      page_template.sort.should eq 2
    end

    it 'should remove template instances' do
      # content of this post request tells which
      # template we want to remove
      xhr :post, :remove_template, {
        page_controller: 'test',
        page_action: 'test',
        page_locale: 'en',
        content: {
          'key'      => 'template_key',
          'template' => 'article',
          'index'    => 0,
        }
      }

      RubberRing::PageTemplate.all.size.should eq 1
    end
  end

end
