require 'spec_helper'

describe "Routing for projects" do

  it "routes the new project path correctly" do
    { :get => "/projects/new" }.should route_to(:controller => "projects", :action => "new")
  end
  
  it "routes the create project path correctly" do
    { :post => "/projects" }.should route_to(:controller => "projects", :action => "create")
  end
  
end
