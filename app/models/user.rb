class User < ActiveRecord::Base
  has_many :identities
  has_many :memberships
  has_many :projects, :through => :memberships
  
  def member_of?(project)
    memberships.select{ |m| m.project == project }.any?
  end
end
