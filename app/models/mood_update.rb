class MoodUpdate < ActiveRecord::Base
  belongs_to :membership

  MOODS = %w(frustrated bored satisfied happy)

  scope :for_project, lambda{ |project| joins(:memberships).where('memberships.project_id = ?', project.id) }
  scope :recent, order('updated_at DESC')

  def self.mood(idx)
    I18n.translate("moods.#{MOODS[idx]}")
  end

  def self.mood_unknown
    I18n.translate("moods.unknown")
  end

  def mood
    self.class.mood(mood_score)
  end

end


