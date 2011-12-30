# == Schema Information
# Schema version: 20111230200612
#
# Table name: memberships
#
#  id         :integer         not null, primary key
#  project_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_memberships_on_project_id  (project_id)
#  index_memberships_on_user_id     (user_id)
#

require 'spec_helper'

describe Membership do
  
  it { should belong_to(:user) }
  it { should belong_to(:project) }
  
  it "has a mood" do
    subject.mood_updates.stub(:recent => [mock_model(MoodUpdate, :mood => 'happy')]) 
    subject.mood.should == 'happy'
  end
  
end
