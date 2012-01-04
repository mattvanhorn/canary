# == Schema Information
# Schema version: 20111230200612
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  company_id :integer
#
# Indexes
#
#  index_projects_on_company_id           (company_id)
#  index_projects_on_company_id_and_name  (company_id,name) UNIQUE
#

class Project < ActiveRecord::Base
  belongs_to :company
  accepts_nested_attributes_for :company, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  has_many :memberships
  has_many :users, :through => :memberships
  has_many :mood_updates, :through => :memberships
  has_many :invitations

  validates :name, :presence =>true, :uniqueness => {:scope => :company_id}


  def company_attributes=(params)
    if new_record?
      self.company = Company.for_new_project(params[:id], params[:name])
    end
  end

  def company_name
    company.try(:name)
  end

  def most_recent_mood_updates
    # yes, it cross joins, but I'm hoping indexes on project_id, membership_id help
    Rails.cache.fetch(self.cache_key + '/most_recent_mood_updates') do
      sql = <<-EOS
        SELECT mu1.*
        FROM mood_updates AS mu1
        INNER JOIN memberships m ON mu1.membership_id = m.id
        LEFT OUTER JOIN mood_updates AS mu2 ON (
          (mu2.membership_id = mu1.membership_id)
          AND
          (mu2.updated_at > mu1.updated_at)
        )
        WHERE (
          m.project_id = #{self.id}
          AND
          mu2.updated_at IS NULL
        )
        ORDER BY mu1.updated_at DESC
      EOS
      result = MoodUpdate.find_by_sql(sql)
      result
    end
  end

  def recent_mood_scores
    most_recent_mood_updates.map{|mood_update|mood_update.mood_score}
  end

  def average_mood_score
    scores = recent_mood_scores
    scores.sum.to_f / scores.size if scores.any?
  end

  def mood
    score = average_mood_score
    if score
      MoodUpdate.mood(score)
    else
      MoodUpdate.mood_unknown
    end
  end

  def mood_history
    @history ||= MoodHistory.new(self)
  end

end
