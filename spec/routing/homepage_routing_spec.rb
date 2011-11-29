require 'spec_helper'

describe "Routing for homepage" do
  # it "routes the omniauth identity login path correctly" do
  #   { :get => "/auth/identity" }.should route_to(:controller => "sessions", :action => "new")
  # end
  # it "routes the omniauth identity registration path correctly" do
  #   { :get  => "/auth/identity/registration" }.should route_to(:controller => "users", :action => "new")
  # end
  it "routes the root path correctly" do
    { :get => "/" }.should route_to(:controller => "homepage", :action => "index")
  end
end
