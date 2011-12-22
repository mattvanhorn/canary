class Project < ActiveRecord::Base
  belongs_to :company
  accepts_nested_attributes_for :company, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :invitations
  has_many :mood_updates
  
  validates :name, :presence =>true, :uniqueness => {:scope => :company_id}
  
  def most_recent_mood_updates
    # yes, it cross joins, but I'm hoping indexes on project_id, user_id help
    Rails.cache.fetch(self.cache_key + '/most_recent_mood_updates') do
      sql = <<-EOS
        SELECT mu1.*
        FROM mood_updates AS mu1
        LEFT OUTER JOIN mood_updates AS mu2 ON (
          (mu2.user_id = mu1.user_id) 
          AND 
          (mu2.project_id = mu1.project_id)
          AND
          (mu2.updated_at > mu1.updated_at)
        )
        WHERE mu2.updated_at IS NULL
        AND mu1.project_id = #{self.id}
        ORDER BY mu1.user_id
      EOS
      result = MoodUpdate.find_by_sql(sql)
    end
  end
  
  def average_mood_score
    Rails.cache.fetch(self.cache_key + '/average_mood_score') do
      scores = most_recent_mood_updates.map{|m|m.mood_score}
      sum = scores.sum.to_f
      number = scores.size
      if number > 0
        (sum / number)
      else
        return nil
      end
    end
  end
  
  def mood
    Rails.cache.fetch(self.cache_key + '/mood') do
      score = average_mood_score
      if score
        MoodUpdate.mood(score.round) 
      else
        MoodUpdate.mood_unknown
      end
    end
  end
end
