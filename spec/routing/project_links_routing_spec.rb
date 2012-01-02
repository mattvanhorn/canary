require 'spec_helper'

describe "Routing for project links" do

  it "routes the create method correctly" do
    { :post => "/project_links" }.should route_to(:controller => "project_links", :action => "create")
  end
end
