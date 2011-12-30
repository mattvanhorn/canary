class Membership < ActiveRecord::Base
  belongs_to :project, :inverse_of => :memberships, :touch => true
  belongs_to :user, :inverse_of => :memberships

  has_many :mood_updates

  scope :for_project, lambda{ |project| where(:project_id => project.id) }

  def mood
    @mood ||= (most_recent_mood_update.try(:mood) || MoodUpdate.mood_unknown)
  end

  def most_recent_mood_update
    mood_updates.recent.first
  end

end
