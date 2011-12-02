class RegistrationsController < ApplicationController
  expose(:identity) { @identity }
  
  def failure
    @identity = request.env['omniauth.identity']
    messages =[]
    errors = @identity.errors.each do |attr, error_msg|
      messages << "#{attr.to_s.humanize} #{error_msg}" unless attr == :password_digest
    end
        
    redirect_to sign_up_url, :alert => messages.flatten
  end
end