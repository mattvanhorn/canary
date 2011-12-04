require 'spec_helper'

describe ProjectsController do
  include ProjectSpecHelper
  
  describe "#create" do
        
    describe "with valid params" do
      before(:each) do
        @project = mock_model(Project, :save => true)
        Project.stub!(:new => @project)
      end
      
      it "creates a new project" do
        Project.should_receive(:new).with(valid_project_attributes).and_return(@project)
        post :create, :project => valid_project_attributes
      end
      
      it "saves the new project" do
        @project.should_receive(:save).and_return(true)
        post :create, :project => valid_project_attributes
      end
      
      it "redirects to the show project page" do
        post :create, :project => valid_project_attributes
        response.should redirect_to(project_path(@project))
      end
    end
    
    describe "with invalid params" do
      before(:each) do
        @project = mock_model(Project, :save => false, :new_record? => true)
        Project.stub!(:new => @project)
      end
      
      it "redisplay the new project form" do
        post :create, :project => {}
        response.should render_template(:new)
      end
    end
  end
end
