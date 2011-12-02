require 'spec_helper'

describe SessionsController do
  describe "#create" do
    before(:each) do
      @mock_user = mock_model(User)
      @mock_identity = mock_model(Identity, :user => @mock_user)
      Identity.stub(:find_from_hash).and_return(@mock_identity)
    end
    
    it "identifies the authenticated user" do
      Identity.should_receive(:find_from_hash).and_return(@mock_identity)
      get :create, :provider => 'identity'
    end
    
    it "logs in the authenticated user as the current user" do
      controller.should_receive(:current_user=).with(@mock_user)
      get :create, :provider => 'identity'
    end
    
    it "redirects to the home page" do
      get :create, :provider => 'identity'
      response.should redirect_to(root_url)
    end
  end
  
  describe "#failure" do
    before(:each) do
      @request.env["omniauth.error.type"] = 'invalid_credentials'
    end
    
    it "redirects to the sign in page" do
      get :failure
      response.should redirect_to(sign_in_url)
    end
    
    it "sets a flash alert message" do
      # rake spec and rspec scope the message key differently.
      I18n.should_receive(:t).with('invalid_credentials').and_return(I18n.translate('sign_in.invalid_credentials'))
      
      get :failure
      flash[:alert].should == 'Your email address or password is incorrect'
    end
  end
  
  describe "#destroy" do
    before(:each) do
      get :destroy
    end
    
    it "clears the current user" do
      controller.send(:current_user).should be_nil
    end
    
    it "clears the user id from the session" do
      session[:user_id].should be_nil
    end
    
    it "redirects to the home page" do
      response.should redirect_to(root_url)
    end
  end

end
