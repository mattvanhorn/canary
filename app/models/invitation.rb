# == Schema Information
# Schema version: 20111230200612
#
# Table name: invitations
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  project_id      :integer
#  recipient_email :string(255)
#  token           :string(255)
#  state           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_invitations_on_project_id  (project_id)
#  index_invitations_on_token       (token) UNIQUE
#  index_invitations_on_user_id     (user_id)
#

class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user_id, :presence =>true
  validates :project_id, :presence => true
  validates :token, :presence => true, :uniqueness => true

  before_validation :generate_token, :on => :create

  state_machine :initial => :pending do
    state :pending
    state :delivered
    state :accepted
    before_transition :pending => :delivered, :do => :delivery

    event :deliver do
      transition :pending => :delivered
    end

    event :accept do
      transition :delivered => :accepted
    end

  end


  def Invitation.for_token(token)
    where(:token => token).first
  end

  def to_join(project)
    self.project = project
    self
  end

  def delivery
    generate_token && InvitationMailer.invitation(self).deliver
  end

  def sender_email
    user.email
  end

  def project_name
    project.name
  end

  protected

  def generate_token
    self[:token] ||= SecureRandom.base64(15).tr('+/=', '').strip.delete("\n")
  end
end
