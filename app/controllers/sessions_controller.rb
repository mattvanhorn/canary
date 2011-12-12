class SessionsController < ApplicationController
  
  def create
    user = User.find_from_hash(auth_hash)
    self.current_user = user
    redirect_back_or_default
  end
  
  def failure
    redirect_to sign_in_url, :alert => I18n.t(request.env['omniauth.error.type'])
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
