class MoodUpdate < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  MOODS = %w(frustrated bored satisfied happy)
  
  scope :for_project, lambda{ |project| where(:project_id => project.id) }
  scope :for_user, lambda{ |user| where(:user_id => user.id) }
  scope :recent, order('updated_at DESC')
  
  def self.mood(idx)
    I18n.translate("moods.#{MOODS[idx]}")
  end
  
  def mood
    self.class.mood(mood_score)
  end
  
end
