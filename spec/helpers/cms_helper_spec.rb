require 'spec_helper'

describe RubberRing::CmsHelper do

  describe 'editable_field' do
    it 'should return editable element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test', content: {}})
      page.edit_mode = true

      helper.editable_field(:div, {key: 'key'}, page){''}
        .should eq '<div contenteditable="true" data-cms-group="" data-cms="key"></div>'
      helper.editable_field(:div, {key: 'key'}, page){'content'}
        .should eq '<div contenteditable="true" data-cms-group="" data-cms="key">content</div>'
    end

    it 'should return non-editable element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test', content: {}})

      helper.editable_field(:div, {key: 'key'}, page){''}
        .should eq '<div data-cms-group="" data-cms="key"></div>'
      helper.editable_field(:div, {key: 'key'}, page){'content'}
        .should eq '<div data-cms-group="" data-cms="key">content</div>'
    end
  end

  describe 'title' do
    it 'should return editable span element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test', content: {}})
      page.edit_mode = true

      helper.title(page){''}.should eq '<span contenteditable="true" data-cms-group="" data-cms="page_title"></span>'
      helper.title(page){'title'}.should eq '<span contenteditable="true" data-cms-group="" data-cms="page_title">title</span>'
    end

    it 'should return non-editable span tag' do
      page = RubberRing::Page.new({controller: 'test', action: 'test', content: {}})

      helper.title(page){''}.should eq '<span data-cms-group="" data-cms="page_title"></span>'
      helper.title(page){'title'}.should eq '<span data-cms-group="" data-cms="page_title">title</span>'
    end
  end

  describe 'editable_image' do
    it 'should return editable image element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test', content: {}})
      page.edit_mode = true

      helper.editable_image({key: 'key', src: '/images/baws.jpg'}, page)
        .should eq '<img class="rubber_ring_image" data-cms="key" src="/images/baws.jpg" />'
    end
  end

  describe 'duplicable_editable_field' do
    it 'should return repeatable element'
  end

end
