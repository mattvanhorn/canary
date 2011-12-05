class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def user_signed_in?
    !!current_user
  end

  helper_method :current_user, :user_signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
  
  def authenticate_user!
    unless user_signed_in?
      store_location
      redirect_to sign_in_url, :alert => 'You need to sign in for access to this page.'
    end
  end
  
  def store_location
    session[:return_to] = request.url
  end
  
  def stored_location
    destination = session[:return_to]
    session[:return_to] = nil
    destination
  end
  
  def redirect_back_or_default(fallback = nil)
    redirect_to( stored_location || fallback || root_path )
  end
end
