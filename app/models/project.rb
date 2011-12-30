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
      self.company = get_company_for_create(params[:id], params[:name])
    end
  end

  def company_name
    company.name unless company.nil?
  end

  def most_recent_mood_updates
    # yes, it cross joins, but I'm hoping indexes on project_id, user_id help
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
    key = self.cache_key + '/mood'
    Rails.cache.fetch(key) do
      Rails.logger.info("CACHE MISS")
      score = average_mood_score
      if score
        MoodUpdate.mood(score.round)
      else
        MoodUpdate.mood_unknown
      end
    end
  end

  protected

  def get_company_for_create(company_id, company_name)
    return Company.find_by_id(company_id) unless company_id.blank?
    return Company.find_or_create_by_name(company_name) unless company_name.blank?
  end
end
