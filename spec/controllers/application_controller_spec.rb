require 'spec_helper'

describe ApplicationController do
  before(:each) do
    @mock_user = mock_model(User)
  end
  
  describe "current_user" do
    
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
  
  describe "user_signed_in?" do
    
    it "should be false if no one is logged in" do
      subject.send(:user_signed_in?).should == false
    end
    
    it "should be true if a user is logged in" do
      subject.stub(:session).and_return( user_id: "my_id")
      User.stub(:find_by_id).and_return(@mock_user)      
      subject.send(:user_signed_in?).should == true
    end
  end
end
