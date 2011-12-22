require 'spec_helper'

describe "Routing for companies" do

  it "routes the new project path correctly" do
    { :get => "/companies" }.should route_to(:controller => "companies", :action => "index")
  end
  
  it "routes the company projects path correctly" do
    { :get => "companies/42/projects" }.should route_to(:controller => "projects", :action => "index", :company_id => "42")
  end
  
end
