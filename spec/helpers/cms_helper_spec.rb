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
        .should eq '<div data-cms="key"></div>'
      helper.editable_field(:div, {key: 'key'}, page){'content'}
        .should eq '<div data-cms="key">content</div>'
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

      helper.title(page){''}.should eq '<span data-cms="page_title"></span>'
      helper.title(page){'title'}.should eq '<span data-cms="page_title">title</span>'
    end
  end

  describe 'editable_image' do
    it 'should return editable image element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})
      page.edit_mode = true

      helper.editable_image({key: 'key', src: '/images/baws.jpg'}, page)
        .should eq '<img class="rubber_ring_image" data-cms="key" src="/images/baws.jpg" />'
    end
  end

  describe 'attachment' do
    it 'should return editable attachment element' do
      page = RubberRing::Page.new({controller: 'test', action: 'test'})
      page.edit_mode = true

      helper.attachment({key: 'software-architecture', href: '/docs/test.pdf'}, page){raw('<span>Link title</span>')}
        .should eq '<a class="rubber_ring_attachment" data-cms="software-architecture" download="" href="/docs/test.pdf"><span>Link title</span></a>'
    end
  end

end
