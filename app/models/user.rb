class User < ActiveRecord::Base
  has_one  :identity, :dependent => :destroy
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :invitations
  
  delegate :email, :to => :identity
  
  def member_of?(project)
    memberships.select{ |m| m.project == project }.any?
  end
  
  def invite(email)
    invitations.new(:recipient_email => email)
  end
  
end
