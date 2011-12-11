require 'spec_helper'

describe Identity do
  
  it { should belong_to(:user) }
  
  describe "find_from_hash" do
    
    it "looks for an Identity with an id that matches the hash uid" do
      Identity.should_receive(:where).with(hash_including(:id => '1')).and_return(mock('arel', :first => nil))
      Identity.find_from_hash({'provider' => 'identity', 'uid' => '1', 'info' => {'email' => 'test@example.com'}})
    end
  end
  
  describe "being created" do
    let(:token){ 'abc123' }
    let(:project){ stub_model(Project) }
    let(:required_attributes_hash){ {:email => 'test@example.com', :password => 'password', :password_confirmation => 'password'} }
    let(:user){ mock_model(User, :join => project) }
    
    before(:each) do
      User.stub(:create).and_return user
    end
    
    it "creates a user" do
      User.should_receive(:create).and_return(user)
      identity = Identity.create(required_attributes_hash)
      identity.user.should == user
    end
    
    it "sets up from invitation if given one" do
      identity = Identity.new
      identity.setup_from_invitation(stub_model(Invitation, :recipient_email => 'friend@example.com', :project => project))
      identity.email.should == 'friend@example.com'
    end
    
    it "uses a token to populate project for user if possible" do
      identity = Identity.new(required_attributes_hash)
      identity.setup_from_invitation(stub_model(Invitation, :recipient_email => 'friend@example.com', :project => project))
      user.should_receive(:join).with(project)
      identity.save
    end
  end
  
  
end
