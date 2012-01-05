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
    let(:user) { stub_model(User, :errors => {:email => "Email can't be blank"}) }

    it "assigns the user" do
      pending "more knowledge of rack tests"
    end

    it "renders the sign_up page" do
      pending "more knowledge of rack tests"
    end
  end

  describe "when already signed in" do
    before(:each) do
      controller.stub(:user_signed_in? => true)
    end
    it "redirects to the home page" do
      get :new
      response.should redirect_to( root_url)
    end
  end
end
