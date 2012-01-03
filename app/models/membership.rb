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

class Membership < ActiveRecord::Base
  belongs_to :project, :touch => true, :inverse_of => :memberships
  belongs_to :user, :inverse_of => :memberships

  has_many :mood_updates

  scope :for_project, lambda{ |project| where(:project_id => project.id) }

  def mood
    @mood ||= most_recent_mood_update.try(:mood)
  end

  def mood_on(date)
    mood_updates.on_date(date).first.try(:mood)
  end

  def most_recent_mood_update
    mood_updates.recent.first
  end

end
