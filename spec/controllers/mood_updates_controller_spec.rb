require 'spec_helper'

describe MoodUpdatesController do
  let(:post_params){ {:project_id => 42, :mood_update => {:mood_score => '3'}} }
  let(:project){ stub_model(Project) }
  let(:user){ stub_model(User, :update_mood_for_project => true) }

  before(:each) do
    Project.stub(:find).and_return(project)
    controller.stub(:current_user).and_return(user)
  end

  describe "#create" do

    it "redirects to the project moods page" do
      post :create, post_params
      response.should redirect_to(project_url(project))
    end

    it "updates the current user's mood for the project" do
      user.should_receive(:update_mood_for_project).with(controller.project, controller.mood_update)
      post :create, post_params
    end
  end
end
