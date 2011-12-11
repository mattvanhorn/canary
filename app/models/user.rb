class User < ActiveRecord::Base
  has_one  :identity, :dependent => :destroy
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :invitations
  has_many :mood_updates
  
  delegate :email, :to => :identity
  
  def join(project)
    projects << project
  end
  
  def member_of?(project)
    projects.select{ |p| p == project }.any?
  end
  
  def invite(email)
    invitations.new(:recipient_email => email)
  end
  
end
