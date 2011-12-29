require 'spec_helper'

describe User do 
  let(:user){ User.new }
  let(:project){ stub_model(Project, :valid? => true)}
  it { should have_db_column(:email).of_type(:string) }
  
  it { should have_many(:memberships) }
  it { should have_many(:projects).through(:memberships) }
  it { should have_many(:invitations) }
  it { should have_many(:mood_updates) }
  
  describe "find_from_hash" do
    
    it "looks for an User with an id that matches the hash uid" do
      User.should_receive(:where).with(hash_including(:id => '1')).and_return(mock('arel', :first => nil))
      User.find_from_hash({'provider' => 'identity', 'uid' => '1', 'info' => {'email' => 'test@example.com'}})
    end
  end
  
  describe "being created" do
    let(:token){ 'abc123' }
    let(:invitation){ stub_model(Invitation, :recipient_email => 'friend@example.com', :project => project) }
    
    before(:each) do
      Invitation.stub(:for_token).and_return(invitation)
    end
    
    it "sets up from invitation if given one" do
      user.setup_from_invitation(invitation)
      user.email.should == 'friend@example.com'
    end
    
    it "uses an invitation to populate project if possible" do
      user.setup_from_invitation(invitation)
      user.projects.should include(project)
    end
    
    it "uses an invitation to populate email if possible" do
      user.setup_from_invitation(invitation)
      user.email.should == 'friend@example.com'
    end
  
    it "uses a token to populate project for user if possible" do
      user.should_receive(:setup_from_invitation).with(invitation)
      user.token = 'abc123'
    end
  end
  
  it "can join a project" do
    user.projects.should_receive(:<<).with(project)
    user.join(project)
  end

  it "can be a member of a project" do
    user.join(project)
    user.should be_member_of(project)
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
  
  it "can update a mood for a particular project" do
    mood_updates  = mock('mood_updates_collection')
    project       = mock('project')
    mood_update   = mock('mood_update')
    memberships   = mock('arel')
    
    mood_updates.should_receive(:<<).with(mood_update)
    memberships.should_receive(:for_project).with(project).and_return([mock_model(Membership, :mood_updates => mood_updates)])
    subject.stub(:memberships).and_return(memberships)
        
    subject.update_mood_for_project(project, mood_update)
  end
end
