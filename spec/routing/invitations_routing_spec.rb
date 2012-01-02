require 'spec_helper'

describe "Routing for invitations" do

  it "routes the new invitation path correctly" do
    { :get => "projects/1/invitations/new" }.should route_to(:controller => "invitations", :action => "new", :project_id => '1')
  end

  it "routes the create invitation path correctly" do
    { :post => "/projects/1/invitations" }.should route_to(:controller => "invitations", :action => "create", :project_id => '1')
  end

end
