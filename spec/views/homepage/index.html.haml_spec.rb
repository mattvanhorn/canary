require 'spec_helper'

describe 'homepage/index.html.haml' do
  
  describe "when not logged in" do
    before(:each) do
      view.stub(:current_user).and_return(nil)
      
      render
    end
    
    it "has a link to register" do
      rendered.should have_selector('a[href="/auth/identity/register"]')
    end
    
    it "has a link to log in" do
      rendered.should have_selector('a[href="/auth/identity"]')
    end
  end
  
  describe "when logged in" do
    before(:each) do
      view.stub(:current_user).and_return(mock('user'))
      render
    end
    
    it "has no link to register" do
      rendered.should_not have_selector('a[href="/auth/identity/register"]')
    end
    
    it "has no link to log in" do
      rendered.should_not have_selector('a[href="/auth/identity"]')
    end
    
    it "has a link to log out" do
      rendered.should have_selector('a[href="/logout"]')
    end
  end
end
