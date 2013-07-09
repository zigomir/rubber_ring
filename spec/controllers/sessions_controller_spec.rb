require 'spec_helper'

describe RubberRing::SessionsController do
  before(:each) { @routes = RubberRing::Engine.routes }

  it 'should display login page' do
    get :new
    response.should be_success
    flash[:error].should be nil
  end

  it 'should not login without a password' do
    post :create
    flash[:error].should == 'Wrong password'
  end

  it 'should not login without a password' do
    post :create, :password => 'wrong_password'
    flash[:error].should == 'Wrong password'
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
