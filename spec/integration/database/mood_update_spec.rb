require 'spec_helper'

describe "scope .on_date" do
  before(:each) do
    MoodUpdate.create(:membership_id => 42, :mood_score => 2, :updated_at => Time.parse('2012-01-02 18:00:00 PST'))
    MoodUpdate.create(:membership_id => 42, :mood_score => 1, :updated_at => Time.parse('2012-01-02 17:00:00 PST'))
    MoodUpdate.create(:membership_id => 42, :mood_score => 0, :updated_at => Time.parse('2012-01-01 17:00:00 PST'))
  end

  it "gets the updates for a certain day" do
    MoodUpdate.on_date(Time.parse('2012-01-01')).first.mood_score.should == 0
  end

  it "orders by updated_at desc" do
    MoodUpdate.on_date(Time.parse('2012-01-02')).first.mood_score.should == 2
    MoodUpdate.on_date(Time.parse('2012-01-02')).second.mood_score.should == 1
  end

end
