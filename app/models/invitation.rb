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
