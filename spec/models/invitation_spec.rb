# == Schema Information
# Schema version: 20111230200612
#
# Table name: invitations
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  project_id      :integer
#  recipient_email :string(255)
#  token           :string(255)
#  state           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_invitations_on_project_id  (project_id)
#  index_invitations_on_token       (token) UNIQUE
#  index_invitations_on_user_id     (user_id)
#

require 'spec_helper'

describe Invitation do
  include NullDB::RSpec::NullifiedDatabase
  include InvitationSpecHelper
  
  let(:invitation){ Invitation.new(valid_invitation_attributes) }
  
  describe "class" do
    it "retrieves an instance by token" do
      Invitation.should_receive(:where).with(:token => 'foobar').and_return([invitation])
      Invitation.for_token('foobar')
    end
  end
  
  it { should belong_to(:user) }
  
  it { should belong_to(:project) }
  
  it { should validate_presence_of(:user_id) }
  
  it { should validate_presence_of(:project_id) }
  
  it "should validate the uniqueness of token" do
    subject.class.validators_on(:token).select{|v|v.is_a? (ActiveRecord::Validations::UniquenessValidator)}.should_not be_empty
    subject.should have_db_index(:token).unique(true)
  end
  
  it { should validate_presence_of(:project_id) }
  
  it "has a recipient email address" do
    invitation.should have_db_column(:recipient_email).of_type(:string)
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
    invitation.to_join(project)
    invitation.project_id.should == project.id
  end
  
  it "generates a unique code before saving" do
    invitation = Invitation.new(valid_invitation_attributes)
    invitation.should_receive(:generate_token).and_return('abc123')
    invitation.save
  end
  
  describe "delivery" do
    
    let(:email) { mock('deliverable', :deliver => true) }
    
    before(:each) do
      InvitationMailer.stub(:invitation).and_return(email)
    end
    
    it "sends itself by email" do
      InvitationMailer.should_receive(:invitation).with(invitation).and_return(email)
      email.should_receive(:deliver)
      invitation.deliver
    end

    it "saves itself before sending" do
      invitation.should_receive(:save).and_return(true)
      invitation.deliver
    end

    it "will not send email if it is not saved" do
      invitation.stub(:save).and_return(false)
      InvitationMailer.should_not_receive(:invitation)
      invitation.deliver
    end
  end

end
