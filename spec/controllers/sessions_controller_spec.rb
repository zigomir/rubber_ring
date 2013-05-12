require 'spec_helper'

describe RubberRing::SessionsController do

  it 'should display login page' do
    get :new
    response.should be_success
  end

  it 'should not login without a passowrd' do
    post :create
    response.code.should == '200' # no password, no login
  end

  it 'should login with correct password' do
    post :create, :password => RubberRing.admin_password
    response.should redirect_to root_path
  end

  it 'should log out' do
    get :destroy
    response.should redirect_to root_path
  end

end
