require 'spec_helper'

describe "project query" do
  describe "for getting each member's most recent mood update" do
    
    before(:each) do
      @project = Project.create(:name => 'test')
      @other_project = Project.create(:name => 'wrong')
      
      member1 = Membership.create(:user_id => 1, :project_id => @project.id)
      member2 = Membership.create(:user_id => 2, :project_id => @project.id)
      member3 = Membership.create(:user_id => 3, :project_id => @project.id)
      member4 = Membership.create(:user_id => 4, :project_id => @other_project.id)
      
      member1.mood_updates.create(:mood_score => 1, :updated_at => 1.hour.ago,  :created_at => 1.hours.ago) # <-- expected
      member1.mood_updates.create(:mood_score => 2, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      member1.mood_updates.create(:mood_score => 2, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      member2.mood_updates.create(:mood_score => 2, :updated_at => 61.minutes.ago, :created_at => 61.minutes.ago) # <-- expected
      member2.mood_updates.create(:mood_score => 3, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      member2.mood_updates.create(:mood_score => 3, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      member3.mood_updates.create(:mood_score => 3, :updated_at => 62.minutes.ago, :created_at => 62.minutes.ago) # <-- expected
      member3.mood_updates.create(:mood_score => 2, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      member3.mood_updates.create(:mood_score => 2, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      member4.mood_updates.create(:mood_score => 0, :updated_at => 1.hour.ago,  :created_at => 1.hours.ago)
      member4.mood_updates.create(:mood_score => 0, :updated_at => 2.hours.ago, :created_at => 2.hours.ago)
      member4.mood_updates.create(:mood_score => 0, :updated_at => 3.hours.ago, :created_at => 3.hours.ago)
      
      @project.mood_updates.size.should == 9
    end
    
    it "gets only the most recent updates for this project from each project member" do
      result = @project.most_recent_mood_updates      
      result.size.should == 3
      
      result.first.membership.user_id.should == 1
      result.first.mood_score.should == 1
      
      result.second.membership.user_id.should == 2
      result.second.mood_score.should == 2
      
      result.third.membership.user_id.should == 3
      result.third.mood_score.should == 3
    end
  end
end