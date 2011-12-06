class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  
  validates :user_id, :presence =>true
  validates :project_id, :presence => true
  
  def to_join(project)
    self.project = project
    self
  end
  
  def deliver
    InvitationMailer.invitation(self).deliver
  end
  
  def sender_email
    user.email
  end
  
  def project_name
    project.name
  end
end
