require 'spec_helper'

describe RubberRing::CmsController do

  it 'should save content for the page' do
    xhr :post, :save, { page_controller: 'test', page_action: 'test', content: { key: 'value' }}
    response.should be_success

    RubberRing::Page.all.size.should eq 1
  end

  it 'should remove key from pages content' do
    # create content with key = "key"
    xhr :post, :save, { page_controller: 'test', page_action: 'test', content: { key: 'value' }}
    # try to remove this key from content
    xhr :post, :remove, {key: 'key', page_controller: 'test', page_action: 'test'}
    response.should be_success
  end

end
