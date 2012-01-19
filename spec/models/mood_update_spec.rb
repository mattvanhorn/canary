# == Schema Information
# Schema version: 20111230200612
#
# Table name: mood_updates
#
#  id            :integer         not null, primary key
#  mood_score    :integer
#  created_at    :datetime
#  updated_at    :datetime
#  membership_id :integer
#
# Indexes
#
#  index_mood_updates_on_membership_id  (membership_id)
#

require 'spec_helper'

describe MoodUpdate do
  it { should have_db_column(:comment).of_type(:string)}
  it { should belong_to :membership }

  it 'should delegate project to membership' do
    MoodUpdate.new.should delegate(:project, :to => :membership)
  end

  it 'should delegate user to membership' do
     MoodUpdate.new.should delegate(:user, :to => :membership)
  end

  it "has a date that it was updated" do
    mood_update = MoodUpdate.new(:updated_at => Time.parse('2012-01-02 18:00:00 PST'))
    mood_update.date.should == Time.parse('2012-01-02 00:00:00 PST')
  end

  describe "displaying mood in plain language" do
    let! (:mood_update){ MoodUpdate.new }

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
