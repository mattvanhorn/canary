require 'spec_helper'

describe RegistrationsController do
  
  describe "GET #new" do
    let!(:user){ stub_model(User) }
    
    before(:each) do
      User.stub(:new).and_return(user)
    end
    
    describe "when a token is provided" do
      let(:token){ 'abc123' }
      let(:project){ stub_model(Project) }
      let(:invitation){ stub_model(Invitation, :recipient_email => 'friend@example.com', :project => project) }

      before(:each) do
        Invitation.stub(:for_token).and_return(invitation)
      end
      
      it "looks up the invitation" do
        Invitation.should_receive(:for_token).with(token).and_return(invitation)
        get :new, :token => token
      end
      
      it "sets up an user with prepoulated email address" do
        user.should_receive(:setup_from_invitation).with(invitation)
        get :new, :token => token
      end
      
      it "stores the project path as the post-sign-in destination" do
        get :new, :token => token
        session[:return_to].should == project_url(project)
      end
      
      it "renders the form" do
        get :new, :token => token
        response.should render_template('new')
      end
    end
    
    it "sets up an user" do
      User.should_receive(:new).and_return(user)
      get :new
    end
    
    it "renders the form" do
      get :new
      response.should render_template('new')
    end
  end

  describe "handling a failed sign-up" do
    let(:user) { stub_model(User, :errors => {:foo => 'bar'}) }
    
    before(:each) do
      request.env['omniauth.identity'] = user
    end
    
    it "puts error messages in the flash" do
      # there is no route for this, it is a rack endpoint for Omniauth, 'get :failure' won't work
      RegistrationsController.action(:failure).call(request.env)
      flash[:alert].should == ['Foo bar']
    end
    
    it "redirects to the sign_up page" do
      status, headers, resp = RegistrationsController.action(:failure).call(request.env)
      # We can't use the standard RSpec response matchers here.
      # Since it is a Rack endpoint, we can test it that way.
      resp.should be_redirect
      resp.redirect_url.should == sign_up_url
    end
  end
end
