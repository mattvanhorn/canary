module InvitationSpecHelper
  def valid_invitation_attributes
    @valid_invitation_attributes ||= {
      'recipient_email' => Faker::Internet.email,
      'user_id' => (rand(9999) + 1).to_s,
      'project_id' => (rand(9999) + 1).to_s
    }
  end
  
  def valid_post_params
    @valid_post_params ||= fake_params(
      'recipient_email' => Faker::Internet.email,
      'project_id' => (rand(9999) + 1).to_s 
    )
  end
  
end