require 'spec_helper'

describe User do
  
  describe "joining a project" do
    let(:user){ User.create(:email => 'alice@example.com', :password => 'password', :password_confirmation => 'password') }

    it "saves a project on joining" do
      project = Project.new(:name => 'foobar')
      user.join(project)
      project.should_not be_new_record
    end

    it "doesn't save an invalid project on joining" do
      project = Project.new(:name => nil)
      user.join(project)
      project.should be_new_record
    end
    
    it "doesn't add an invalid project to the collection" do
      project = Project.new(:name => nil)
      user.join(project)
      user.projects.should be_empty
    end

  end


end