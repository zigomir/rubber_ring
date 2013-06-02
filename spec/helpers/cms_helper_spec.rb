require 'spec_helper'

describe RubberRing::CmsHelper do

  describe 'editable_field' do
    it 'should return editable element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})
      page.edit_mode = true

      helper.editable_field(:div, {key: 'key'}, page){''}
        .should eq '<div contenteditable="true" data-cms="key"></div>'
      helper.editable_field(:div, {key: 'key'}, page){'content'}
        .should eq '<div contenteditable="true" data-cms="key">content</div>'
    end

    it 'should return non-editable element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})

      helper.editable_field(:div, {key: 'key'}, page){''}
        .should eq '<div></div>'
      helper.editable_field(:div, {key: 'key'}, page){'content'}
        .should eq '<div>content</div>'
    end
  end

  describe 'title' do
    it 'should return editable span element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})
      page.edit_mode = true

      helper.title(page){''}.should eq '<span contenteditable="true" data-cms="page_title"></span>'
      helper.title(page){'title'}.should eq '<span contenteditable="true" data-cms="page_title">title</span>'
    end

    it 'should return non-editable span tag' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})

      helper.title(page){''}.should eq '<span></span>'
      helper.title(page){'title'}.should eq '<span>title</span>'
    end
  end

  describe 'editable_image' do
    it 'should return editable image element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})
      page.edit_mode = true

      helper.editable_image({key: 'key', src: '/images/baws.jpg', class: 'class'}, page)
        .should eq '<img class="rubber_ring_image class" data-cms="key" src="/images/baws.jpg" />'
    end
  end

  describe 'link' do
    it 'should return editable link element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})
      page.edit_mode = true

      helper.editable_link({key: 'link', href: '/test', class: 'class'}, page){'Link'}
        .should eq '<a class="class" contenteditable="true" data-cms="link" href="/test">Link</a>'
    end
  end

  describe 'template' do
    it 'should render editable template element' do
      @page = RubberRing::Page.new({controller: 'test', action: 'test'})
      @page.edit_mode = true

      helper.template(
        [{template: 'test_article', tclass: 't-article', element: 'article'}],
        {key: 'template_key_1', wrap_element: 'div', wrap_class: 'templates'},
        @page
      ).should eq '<div class="templates" data-cms="template_key_1"><article class="t-article" data-template-index="0" data-template="test_article"><h2 contenteditable="true" data-cms="0_template_key_1_test_article_title">Article Title</h2></article></div>'
    end

    it 'should render non-editable template element' do
      @page = RubberRing::Page.new({controller: 'test', action: 'test'})

      helper.template(
        [{template: 'test_article', tclass: 't-article', element: 'article'}],
        {key: 'template_key_1', wrap_element: 'div', wrap_class: 'templates'},
        @page
      ).should eq '<div class="templates"><article class="t-article"><h2>Article Title</h2></article></div>'
    end
  end

end
