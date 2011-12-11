class Identity < OmniAuth::Identity::Models::ActiveRecord
  attr_accessor :invitation
  
  belongs_to :user
  before_create :attach_user
  
  validates :email, :password, :password_confirmation, :presence =>true
  
  validates :email, :uniqueness=>true, :if => Proc.new{|i| i.email.present?}
                    
  validates  :password, :length => { :minimum => 5, :maximum => 40 },
                        :confirmation =>true,
                        :if => Proc.new{|i| i.password.present?}
                    
  def self.find_from_hash(auth_hash)
    where(:id => auth_hash['uid']).first
  end
  
  def token=(code)
    setup_from_invitation(Invitation.for_token(code))
  end
  
  def setup_from_invitation(invitation)
    if invitation
      self.invitation = invitation
      self.email ||= invitation.recipient_email
    end
  end
  
  private
  
  def attach_user
    self.user ||= User.create
    if invitation
      self.user.join(invitation.project)
    end
  end
end
