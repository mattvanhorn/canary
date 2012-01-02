require 'spec_helper'

describe ProjectLinksController do

  let(:email){ Faker::Internet.email }
  let(:project){ mock_model(Project) }
  let(:post_params){ {:email => email, :project_id => project.id} }
  let(:mail){ mock('deliverable', :deliver => true) }

  describe "#create" do
    before(:each) do
      controller.stub(:user_signed_in?).and_return(true)
      InvitationMailer.stub(:project_link).and_return(mail)
    end

    describe "valid params" do
      before(:each) do
        Project.stub(:find).and_return(project)
      end
      it "makes a project link email" do
        InvitationMailer.should_receive(:project_link).with(email, project).and_return(mail)
        post :create, post_params
      end

      it "delivers an email" do
        mail.should_receive(:deliver)
        post :create, post_params
      end

      it "redirects to the project page" do
        post :create, post_params
        response.should redirect_to(project_url(project))
      end
    end

    describe "when there is no such project" do
      it "raises a not found error" do
        Project.stub(:find).and_raise(ActiveRecord::RecordNotFound.new)
        expect{ post :create, {:email => email, :project_id => 'bogus'} }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "when email is blank" do
      it "does nothing" do
        Project.stub(:find).and_return(project)
        InvitationMailer.should_not_receive(:project_link)
        mail.should_not_receive(:deliver)
        post :create, {:email => '', :project_id => 'irrelevant'}
      end
    end
  end

end
