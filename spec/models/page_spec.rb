require 'spec_helper'

describe Page do
  it 'should create new page' do
    page = FactoryGirl.create(:page)
    expect(page.controller).to eq 'test'
    expect(page.action).to eq 'test'
    expect(page.content['key']).to eq 'value'
    expect(Page.all.count).to eq 1
  end

  it 'should create new page with content' do
    page = Page.save_or_update({controller: 'test', action: 'test', key: 'key', value: 'value'})

    expect(Page.all.count).to eq 1
    expect(page.content['key']).to eq 'value'
    expect(page.content['key2']).to eq nil
  end

  it 'should add new key to content if page already exist' do
    FactoryGirl.create(:page)
    page = Page.save_or_update({controller: 'test', action: 'test', key: 'key2', value: 'value2'})

    expect(Page.all.count).to eq 1
    expect(page.content['key']).to eq 'value'
    expect(page.content['key2']).to eq 'value2'
  end
end
