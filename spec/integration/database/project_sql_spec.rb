require 'spec_helper'

describe "project query" do
  describe "for getting each member's most recent mood update" do
    
    before(:each) do
      @project = Project.create(:name => 'test')
      @other_project = Project.create(:name => 'wrong')
      
      @project.mood_updates.create(:user_id => 1, :mood_score => 1, :updated_at => 1.hour.ago,  :created_at => 1.hours.ago) # <-- expected
      @project.mood_updates.create(:user_id => 1, :mood_score => 2, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      @project.mood_updates.create(:user_id => 1, :mood_score => 2, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      @project.mood_updates.create(:user_id => 2, :mood_score => 2, :updated_at => 1.hour.ago,  :created_at => 1.hours.ago) # <-- expected
      @project.mood_updates.create(:user_id => 2, :mood_score => 3, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      @project.mood_updates.create(:user_id => 2, :mood_score => 3, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      @project.mood_updates.create(:user_id => 3, :mood_score => 3, :updated_at => 1.hour.ago,  :created_at => 1.hours.ago) # <-- expected
      @project.mood_updates.create(:user_id => 3, :mood_score => 2, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      @project.mood_updates.create(:user_id => 3, :mood_score => 2, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      @other_project.mood_updates.create(:user_id => 4, :mood_score => 0, :updated_at => 1.hour.ago,  :created_at => 1.hours.ago)
      @other_project.mood_updates.create(:user_id => 4, :mood_score => 0, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      @other_project.mood_updates.create(:user_id => 4, :mood_score => 0, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      @project.mood_updates.size.should == 9
    end
    
    it "gets only the most recent updates for this project from each project member" do
      result = @project.most_recent_mood_updates
      result.size.should == 3
      
      result.first.user_id.should == 1
      result.first.mood_score.should == 1
      
      result.second.user_id.should == 2
      result.second.mood_score.should == 2
      
      result.third.user_id.should == 3
      result.third.mood_score.should == 3
    end
  end
end