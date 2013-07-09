require 'spec_helper'

describe RubberRing::AttachmentsController do
  before(:each) { @routes = RubberRing::Engine.routes }

  it 'should save attachment for the page' do
    xhr :post, :save_image, {
      page_controller: 'test',
      page_action: 'test',
      page_locale: 'fr',
      height: '300',
      content: { 'key' => 'value' }
    }
    response.should be_success

    RubberRing::Page.all.size.should eq 1
    RubberRing::PageContent.all.size.should eq 1
    RubberRing::Page.first.locale.should eq 'fr'
  end

end
