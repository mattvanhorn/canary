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

class MoodUpdate < ActiveRecord::Base
  belongs_to :membership

  MOODS = %w(frustrated bored satisfied happy)

  scope :for_project, lambda{ |project| joins(:memberships).where('memberships.project_id = ?', project.id) }
  scope :recent, order('updated_at DESC')

  def self.mood(score)
    I18n.translate("moods.#{MOODS[score.round]}")
  end

  def self.mood_unknown
    I18n.translate("moods.unknown")
  end

  def mood
    self.class.mood(mood_score)
  end

end


