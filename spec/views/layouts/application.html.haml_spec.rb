require 'spec_helper'

describe 'layouts/application.html.haml' do
  
  describe "when not logged in" do
    before(:each) do
      view.stub(:current_user).and_return(nil)
      render
    end
    
    it "has a link to sign up" do
      rendered.should have_selector("a[href='#{sign_up_path}']")
    end
    
    it "has a link to sign in" do
      rendered.should have_selector("a[href='#{sign_in_path}']")
    end
  end
  
  describe "when signed in" do
    before(:each) do
      view.stub(:current_user).and_return(mock('user'))
      render
    end
    
    it "has no link to sign up" do
      rendered.should_not have_selector("a[href='#{sign_up_path}']")
    end
    
    it "has no link to sign in" do
      rendered.should_not have_selector("a[href='#{sign_in_path}']")
    end
    
    it "has a link to sign out" do
      rendered.should have_selector("a[href='#{sign_out_path}']")
    end
    
    it "has a link to my projects" do
      rendered.should have_selector("a[href='#{my_projects_path}']")
    end
    
  end
end
