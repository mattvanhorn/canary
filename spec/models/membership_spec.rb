require 'spec_helper'

describe Membership do
  
  it { should belong_to(:user) }
  it { should belong_to(:project) }
  
  it "has a mood" do
    subject.mood_updates.stub(:recent => [mock_model(MoodUpdate, :mood => 'happy')]) 
    subject.mood.should == 'happy'
  end
  
end
