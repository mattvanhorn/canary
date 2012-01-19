require 'spec_helper'

describe "scopes" do
  let(:membership1){ Membership.create!(:project_id => 13, :user_id => 69 ) }
  let(:membership2){ Membership.create!(:project_id => 42, :user_id => 86 ) }

  before(:each) do
    @first  = MoodUpdate.create!(:membership_id => membership1.id, :mood_score => 2, :updated_at => Time.parse('2012-01-02 15:00:00 PST'))
    @second = MoodUpdate.create!(:membership_id => membership2.id, :mood_score => 1, :updated_at => Time.parse('2012-01-02 16:00:00 PST'))
    @third  = MoodUpdate.create!(:membership_id => membership2.id, :mood_score => 0, :updated_at => Time.parse('2012-01-02 17:00:00 PST'))
  end

  it "gets the updates for a certain project" do
    updates = MoodUpdate.for_project(mock_model(Project, :id => 13))
    updates.should include(@first)
    updates.should_not include(@second)
    updates.should_not include(@third)
  end

  it "'recent' will order by updated_at desc" do
    updates = MoodUpdate.recent
    updates.first.should == @third
    updates.last.should == @first
  end

  it "'chronological' will order by updated_at asc" do
    updates = MoodUpdate.chronological
    updates.first.should == @first
    updates.last.should == @third
  end

end
