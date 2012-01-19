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
  belongs_to :membership, :touch => true
  delegate :project, :to => :membership
  delegate :user, :to => :membership

  MOODS = %w(frustrated bored satisfied happy)

  scope :for_project, lambda{ |project| includes(:membership).where('memberships.project_id = ?', project.id) }
  scope :recent, order("#{table_name}.updated_at DESC")
  scope :chronological, order("#{table_name}.updated_at ASC")
  #scope :on_date, lambda{ |date| where('updated_at BETWEEN ? AND ?', date.beginning_of_day.utc, date.end_of_day.utc ).order('updated_at DESC') }

  def self.mood(score)
    I18n.translate("moods.#{MOODS[score.round]}")
  end

  def self.mood_unknown
    I18n.translate("moods.unknown")
  end

  def mood
    self.class.mood(mood_score)
  end

  def date
    updated_at.in_time_zone.beginning_of_day
  end
end


