require 'spec_helper'

describe RegistrationsController do
  describe "handling a failed sign-up" do
    let(:identity) { stub_model(Identity, :errors => {:foo => 'bar'}) }
    
    before(:each) do
      request.env['omniauth.identity'] = identity
    end
    
    it "puts error messages in the flash" do
      # there is no route for this, it is a rack endpoint for Omniauth, 'get :failure' won't work
      RegistrationsController.action(:failure).call(request.env)
      flash[:alert].should == ['Foo bar']
    end
    
    it "redirects to the sign_up page" do
      status, headers, resp = RegistrationsController.action(:failure).call(request.env)
      # We can't use the standard RSpec response matchers here.
      # Since it is a Rack endpoint, we can test it that way.
      resp.should be_redirect
      resp.redirect_url.should == sign_up_url
    end
  end
end
