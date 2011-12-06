require 'spec_helper'

class TestController < ApplicationController
  before_filter :authenticate_user!
  def index; render :nothing => true; end
end

describe ApplicationController do
  before(:each) do
    @mock_user = mock_model(User)
  end
  
  describe "#current_user" do
    
    it "should return nil if no one is logged in" do
      subject.send(:current_user).should be_nil
    end
    
    it "should get the user id from the session" do
      subject.should_receive(:session).and_return( user_id: "my_id")
      User.stub(:find_by_id).and_return(@mock_user)      
      subject.send(:current_user).should == @mock_user
    end

    it "should return currently logged in user" do
      subject.stub(:session).and_return( user_id: "my_id")
      User.should_receive(:find_by_id).and_return(@mock_user)      
      subject.send(:current_user).should == @mock_user
    end
    
    it "should memoize the logged in user" do
      subject.stub(:session).and_return( user_id: "my_id")
      User.stub(:find_by_id).and_return(@mock_user)      
      subject.send(:current_user)
      subject.instance_variable_get(:'@current_user').should == @mock_user
    end
  end
  
  describe "#user_signed_in?" do
    
    it "should be false if no one is logged in" do
      subject.send(:user_signed_in?).should == false
    end
    
    it "should be true if a user is logged in" do
      subject.stub(:session).and_return( user_id: "my_id")
      User.stub(:find_by_id).and_return(@mock_user)      
      subject.send(:user_signed_in?).should == true
    end
  end
  
  describe "#authenticate_user!" do
    controller(TestController)
    
    it "checks for a signed in user" do
      controller.should_receive(:user_signed_in?).and_return(true)
      get :index
    end
    
    it "stores the current location if the user is not signed in" do
      request.stub(:url).and_return('foo/bar/baz')
      controller.stub(:user_signed_in?).and_return(false)
      get :index
      controller.send(:stored_location).should == 'foo/bar/baz'
    end
    
    it "redirects to sign-in if the user is not signed in" do
      controller.stub(:user_signed_in?).and_return(false)
      get :index
      response.should redirect_to sign_in_url
    end
  end
end
