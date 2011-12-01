require 'spec_helper'

describe "Routing for sessions" do

  it "routes the omniauth identity sign-in callback path correctly" do
    { :get => "/auth/identity/callback" }.should route_to(:controller => "sessions", :action => "create", :provider => "identity")
  end
  
  it "routes the sign-in path correctly" do
    { :get => "/sign-in" }.should route_to(:controller => "sessions", :action => "new")
  end
  
  it "routes the sign-out path correctly" do
    { :get => "/sign-out" }.should route_to(:controller => "sessions", :action => "destroy")
  end
  
  it "routes the sign-in failure page correctly" do
    { :get => "/auth/failure" }.should route_to(:controller => "sessions", :action => "failure")
  end
end
