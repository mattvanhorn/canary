require 'spec_helper'

describe MoodUpdatesHelper do
  describe "moods_and_mood_scores" do
    it "provides an array compatible with optios_for_select" do
      helper.moods_and_mood_scores.should == [['frustrated',0],['bored',1],['satisfied',2],['happy',3]]
    end
  end
end
