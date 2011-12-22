require 'spec_helper'

describe ProjectsController do
  include ProjectSpecHelper
  
  let(:project) { mock_model(Project, :save => true) }
  let(:invalid_project) { mock_model(Project, :save => false, :errors => ['omgwtfbbq?!']) }
  let(:collection){ mock('projects', :scoped => [self], :new => project) }
  let(:current_user){ mock_model(User, :projects => collection, :join => true) }
  
  before(:each) do
    controller.stub(:current_user).and_return(current_user)
    Project.stub(:scoped).and_return(collection)
  end
  
  it "exposes the entire projects collection" do
    Project.should_receive(:scoped)
    controller.projects
  end
  
  it "exposes the company's projects collection" do
    Company.stub(:find_by_id).and_return(stub_model(Company))
    controller.stub(:params).and_return(fake_params(:comapny_id => '42'))
    controller.projects
  end
  
  it "exposes a project from the current user's collection" do
    controller.stub(:params).and_return(fake_params(:id => '42'))
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
        current_user.should_receive(:join).with(project).and_return(true)
        post :create, :project => valid_project_attributes
      end
      
      it "redirects to the my projects page" do
        post :create, :project => valid_project_attributes
        response.should redirect_to(my_projects_url)
      end
    end
    
    describe "with invalid params" do
      
      it "redisplays the new project form" do
        current_user.should_receive(:join).with(project).and_return(nil)
        post :create, :project => {}
        response.should render_template(:new)
      end
    end
  end


end
