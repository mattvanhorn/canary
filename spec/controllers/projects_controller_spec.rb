require 'spec_helper'

describe ProjectsController do
  include ProjectSpecHelper
  
  let(:project) { mock_model(Project, :save => true) }
  let(:invalid_project) { mock_model(Project, :save => false, :errors => ['omgwtfbbq?!']) }
  let(:collection){ mock('projects', :scoped => [self], :new => project) }
  let(:current_user){ mock_model(User, :projects => collection) }
  
  before(:each) do
    controller.stub(:current_user).and_return(current_user)
  end
  
  it "exposes the current_user's projects collection" do
    current_user.should_receive(:projects)
    controller.projects
  end
  
  it "exposes a project from the current user's collection" do
    controller.stub(:params).and_return(:id => '42')
    collection.should_receive(:find)
    controller.project
  end

  describe "#create" do
        
    describe "with valid params" do
      
      it "creates a new project in the current user's projects collection" do
        collection.should_receive(:new).with(valid_project_attributes).and_return(project)
        post :create, :project => valid_project_attributes
      end
      
      it "saves the new project (and the membership associations)" do
        project.should_receive(:save).and_return(true)
        post :create, :project => valid_project_attributes
      end
      
      it "redirects to the show project page" do
        post :create, :project => valid_project_attributes
        response.should redirect_to(project_path(project))
      end
    end
    
    describe "with invalid params" do
      
      it "redisplay the new project form" do
        collection.should_receive(:new).and_return(invalid_project)
        post :create, :project => {}
        response.should render_template(:new)
      end
    end
  end
end
