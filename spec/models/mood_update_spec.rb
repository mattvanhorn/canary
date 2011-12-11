require 'spec_helper'

describe MoodUpdate do

  it { should belong_to :project }
  it { should belong_to :user }
  
  describe "displaying mood in plain language" do
    let! (:mood_update){ MoodUpdate.new }
    
    before(:each) do
      moods = %w(happy satisfied bored frustrated)
    end
    
    it "can be happy" do
      mood_update.mood_score = 3
      mood_update.mood.should == 'happy'
    end
    
    it "can be satisfied" do
      mood_update.mood_score = 2
      mood_update.mood.should == 'satisfied'
    end
    
    it "can be bored" do
      mood_update.mood_score = 1
      mood_update.mood.should == 'bored'
    end
    
    it "can be frustrated" do
      mood_update.mood_score = 0
      mood_update.mood.should == 'frustrated'
    end
  end
end
