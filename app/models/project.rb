class Project < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :invitations
  
  validates :name, :presence =>true, :uniqueness => true
end
