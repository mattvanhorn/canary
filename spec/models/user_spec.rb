require 'spec_helper'

describe User do 
  let(:user){ User.new }
  let(:project){ stub_model(Project)}
  
  it { should have_one( :identity) }
  it { should have_many(:memberships) }
  it { should have_many(:projects).through(:memberships) }
  it { should have_many(:invitations) }
  it { should have_many(:mood_updates) }
  
  it "can join a project" do
    user.projects.should_receive(:<<).with(project)
    user.join(project)
  end
  
  it "can be a member of a project" do
    # membership = stub_model(Membership, :project => project)
    # user.memberships << membership
    user.join(project)
    user.should be_member_of(project)
  end
  
  it "has an email via it's identity" do
    identity = stub_model(Identity, :email => 'alice@example.com')
    user = User.new(:identity => identity)
    user.email.should == 'alice@example.com'
  end
  
  describe "calling #invite" do
    let(:invitation){ mock_model(Invitation) }
    
    before(:each) do
      @user = User.new()
      @user.invitations.should be_empty
    end
    
    it "returns a new invitation" do
      @user.invite("bob@example.com").should be_a(Invitation)
    end
    
    it "adds to the user's invitation collection" do
      @user.invite("bob@example.com")
      @user.invitations.should have(1).invitation
    end
    
    it "sets the recipient properly" do
      @user.invite("bob@example.com")
      @user.invitations.first.recipient_email.should == "bob@example.com"
    end
  end
end
