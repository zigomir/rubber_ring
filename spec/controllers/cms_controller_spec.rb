require 'spec_helper'

describe RubberRing::CmsController do

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

  it 'should save templates for the page' do
    xhr :post, :save_template, {
      page_controller: 'test',
      page_action: 'test',
      page_locale: 'fi',
      content: {
          'template_key' => {
            '0' => {
              'index'    => 0,
              'template' => 'blog_post',
              'sort'     => 1
            }
          }
        }
      }
    response.should be_success

    RubberRing::Page.all.size.should eq 1
    RubberRing::PageContent.all.size.should eq 0
    RubberRing::PageTemplate.all.size.should eq 1
    RubberRing::Page.first.locale.should eq 'fi'
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

end
