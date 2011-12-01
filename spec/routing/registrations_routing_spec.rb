require 'spec_helper'

describe "Routing for registrations" do
  it "routes the new registration page correctly" do
    { :get => "/sign-up" }.should route_to(:controller => "registrations", :action => "new")
  end
end
