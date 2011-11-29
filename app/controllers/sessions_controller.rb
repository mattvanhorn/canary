class SessionsController < ApplicationController
  def create
    @identity = Identity.find_from_hash(auth_hash)
    self.current_user = @identity.user
    redirect_to '/'
  end
  
  def destroy
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_url
  end
  
  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
