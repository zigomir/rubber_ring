require 'spec_helper'

describe Page do
  it 'should create new page' do
    page = FactoryGirl.create(:page)
    expect(page.controller).to eq 'test'
    expect(page.action).to eq 'test'
    expect(page.content[:key]).to eq 'value'
    expect(Page.all.count).to eq 1
  end

  it 'should add new key to content if page already exist' do

  end
end
