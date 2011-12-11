class RegistrationsController < ApplicationController
  expose(:identity) { @identity }
  
  def new
    @identity = Identity.new
    token = params[:token]
    if token.present?
      invitation = Invitation.for_token(token)
      if invitation
        store_location project_url(invitation.project)
        @identity.setup_from_invitation(invitation)
      end
    end
  end

  def failure
    @identity = request.env['omniauth.identity']
    messages =[]
    errors = @identity.errors.each do |attr, error_msg|
      messages << "#{attr.to_s.humanize} #{error_msg}" unless attr == :password_digest
    end
        
    redirect_to sign_up_url, :alert => messages.flatten
  end
end