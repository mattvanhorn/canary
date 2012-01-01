require 'spec_helper'

describe 'layouts/application.html.haml' do
  let(:user) { mock_model(User, :email => Faker::Internet.email) }
  let(:mock_analytics) { mock('analytical',  :head_prepend_javascript => '',
                                             :head_append_javascript => '',
                                             :body_prepend_javascript => '',
                                             :body_append_javascript => '',
                                             :identify => 'true') }

  before(:each) do
    view.stub(:analytical).and_return(mock_analytics)
  end

  describe "when not signed in" do
    before(:each) do
      view.stub(:user_signed_in?).and_return(false)
      render
    end

    it "has a link to sign up" do
      rendered.should have_selector("a[href='#{sign_up_path}']")
    end

    it "has a link to sign in" do
      rendered.should have_selector("a[href='#{sign_in_path}']")
    end

    it "has no link to sign out" do
      rendered.should_not have_selector("a[href='#{sign_out_path}']")
    end

    it "has a link to companies" do
      rendered.should have_selector("a[href='#{companies_path}']")
    end

    it "has a link to projects" do
      rendered.should have_selector("a[href='#{projects_path}']")
    end

    [:head_prepend_javascript,
    :head_append_javascript,
    :body_prepend_javascript,
    :body_append_javascript].each do |snippet|
      it "includes the #{snippet} content" do
        mock_analytics.should_receive(snippet)
        render
      end
    end

    it "does not identify the user" do
      mock_analytics.should_not_receive(:identify)
      render
    end
  end

  describe "when signed in" do
    before(:each) do
      view.stub(:user_signed_in?).and_return(true)
      view.stub(:current_user).and_return(user)
      render
    end

    it "has no link to sign up" do
      rendered.should_not have_selector("a[href='#{sign_up_path}']")
    end

    it "has no link to sign in" do
      rendered.should_not have_selector("a[href='#{sign_in_path}']")
    end

    it "has a link to sign out" do
      rendered.should have_selector("a[href='#{sign_out_path}']")
    end

    it "has a link to companies" do
      rendered.should have_selector("a[href='#{companies_path}']")
    end

    it "has a link to projects" do
      rendered.should have_selector("a[href='#{projects_path}']")
    end

    [:head_prepend_javascript,
    :head_append_javascript,
    :body_prepend_javascript,
    :body_append_javascript].each do |snippet|
      it "includes the #{snippet} content" do
        mock_analytics.should_receive(snippet)
        render
      end
    end

    it "identifies the user for analytics" do
      mock_analytics.should_receive(:identify).with(user.id, :email => user.email)
      render
    end
  end
end
