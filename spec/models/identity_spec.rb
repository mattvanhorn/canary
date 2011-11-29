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
    it "creates a user" do
      mock_user = mock_model(User)
      User.should_receive(:create).and_return(mock_user)
      subject = Identity.create(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password')
      subject.user.should == mock_user
    end
  end
end
