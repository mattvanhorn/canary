class OmniAuth::Strategies::Identity
  def callback_phase
    unless identity
      return fail!('sign_in.email_and_password_missing') if (request['auth_key'].blank? && request['password'].blank?)
      return fail!('sign_in.email_missing') if request['auth_key'].blank?
      return fail!('sign_in.password_missing') if request['password'].blank?
      return fail!('sign_in.invalid_credentials')
    end
    super
  end 
end

OmniAuth.config.on_failure = SessionsController.action(:failure)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :fields => [:email, :token], 
                      :model => User,
                      :form => SessionsController.action(:new),
                      :on_failed_registration => RegistrationsController.action(:failure)
end

