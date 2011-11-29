require 'spec_helper'

describe "Routing for status" do

  it "routes the new status page correctly" do
    { :get => "/status/new" }.should route_to(:controller => "statuses", :action => "new")
  end
end
