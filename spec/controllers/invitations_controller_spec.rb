require 'spec_helper'

describe InvitationsController do
  include InvitationSpecHelper

  let(:invitation) { mock_model(Invitation) }
  let(:invalid_invitation) { mock_model(Invitation, :deliver! => nil, :errors => ['omgwtfbbq?!']) }

  let(:collection){ mock('invitations', :scoped => [], :new => invitation) }
  let(:project) { mock_model(Project, :invitations => collection) }
  let(:projects) { mock('projects', :scoped => [], :find => project) }

  let(:current_user){ mock_model(User, :invite => invitation) }

  before(:each) do
    controller.stub(:params).and_return(fake_params('project_id' => '42'))
    controller.stub(:current_user).and_return(current_user)
    current_user.stub(:projects).and_return(projects)
    invitation.stub(:to_join).and_return(invitation)
  end

  it "exposes a project from the current_user's projects" do
    current_user.should_receive(:projects).and_return(projects)
    projects.should_receive(:find).with('42').and_return(project)
    controller.project
  end

  it "exposes the invitations collection for the project" do
    project.should_receive(:invitations).and_return(collection)
    controller.invitations
  end

  it "exposes a new invitation" do
    collection.should_receive(:new)
    controller.invitation
  end

  it "exposes an existing invitation" do
    controller.stub(:params).and_return(fake_params('project_id' => '42', :id => '12'))
    collection.should_receive(:find)
    controller.invitation
  end

  describe "#new" do
    it "requires authentication" do
      controller.should_receive(:user_signed_in?).and_return(false)
      get :new, 'project_id' => '42'
      response.should redirect_to( sign_in_url)
    end
  end

  describe "#create" do
    before(:each) do
      # TODO patch decent_exposure, so that it doesn't automatically try to
      # set attributes on eveything it exposes even when they are nil/blank
      project.stub(:attributes=)
    end

    it "requires authentication" do
      controller.should_receive(:user_signed_in?).and_return(false)
      post :create, valid_post_params
      response.should redirect_to( sign_in_url)
    end

    describe "receiving valid params" do
      before(:each) do
        invitation.stub(:deliver!).and_return(true)
        @recipient_email = valid_post_params['invitation']['recipient_email']
      end

      it "sends an invitation from the current user to the recipient" do
        current_user.should_receive(:invite).with(@recipient_email).and_return(invitation)
        post :create, valid_post_params
      end

      it "sends an invitation for the project" do
        invitation.should_receive(:to_join).with(project).and_return(invitation)
        post :create, valid_post_params
      end

      it "delivers the new invitation" do
        invitation.should_receive(:deliver!).and_return(true)
        post :create, valid_post_params
      end

      it "redirects to the project page" do
        post :create, valid_post_params
        response.should redirect_to(project_path(project))
      end
    end

    describe "receiving invalid params" do
      before(:each) do
        current_user.stub_chain(:invite, :to_join).and_return(invalid_invitation)
      end

      it "redisplays the project invitation form" do
        post :create, 'invitation' => {}, 'project_id' => '42'
        response.should render_template(:new)
      end
    end
  end

end
