require 'spec_helper'

describe "Routing for sessions" do

  it "routes the omniauth identity login callback path correctly" do
    { :get => "/auth/identity/callback" }.should route_to(:controller => "sessions", :action => "create", :provider => "identity")
  end
  
  it "routes the logout path correctly" do
    { :get => "/logout" }.should route_to(:controller => "sessions", :action => "destroy")
  end
end
