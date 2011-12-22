class Company < ActiveRecord::Base
  has_many :projects
  
  validates :name, :presence =>true, :uniqueness => true
  
  def mood
    'unknown'
  end
  
end