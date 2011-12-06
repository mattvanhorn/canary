require 'spec_helper'

describe Invitation do
  include NullDB::RSpec::NullifiedDatabase
  include InvitationSpecHelper
  
  before(:each) do
    @invitation = subject
  end
  
  it { should belong_to(:user) }
  
  it { should belong_to(:project) }
  
  it { should validate_presence_of(:user_id) }
  
  it { should validate_presence_of(:project_id) }
  
  it "has a recipient email address" do
    subject.should have_db_column(:recipient_email).of_type(:string)
  end
  
  it "has a sender email address" do
    invitation = Invitation.new(:user => mock_model(User, :email => 'alice@example.com'))
    invitation.sender_email.should eq('alice@example.com')
  end
  
  it "has a project name" do
    invitation = Invitation.new(:project => mock_model(Project, :name => 'Yoyodyne Website'))
    invitation.project_name.should eq('Yoyodyne Website')
  end
  
  it "sets the project correctly" do
    project = mock_model(Project)
    @invitation.to_join(project)
    @invitation.project_id.should == project.id
  end
  
  it "sends itself" do
    email = mock('deliverable')
    @invitation = Invitation.new(valid_invitation_attributes)
    InvitationMailer.should_receive(:invitation).with(@invitation).and_return(email)
    email.should_receive(:deliver)
    @invitation.deliver
  end
end