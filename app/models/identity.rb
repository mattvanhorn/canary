class Identity < OmniAuth::Identity::Models::ActiveRecord
  belongs_to :user
  before_create :attach_user
  
  def self.find_from_hash(auth_hash)
    where(:id => auth_hash['uid']).first
  end
  
  private
  
  def attach_user
    self.user ||= User.create
  end
end
