# for sign-in and sign-out
#               /auth/:provider/callback(.:format)  {:controller=>"sessions", :action=>"create"}
# auth_failure  /auth/failure(.:format)             {:controller=>"sessions", :action=>"failure"}
#      sign_in  /sign-in(.:format)                  {:controller=>"sessions", :action=>"new"}
#     sign_out  /sign-out(.:format)                 {:controller=>"sessions", :action=>"destroy"}

class SessionsController < ApplicationController

  def create
    user = User.find_from_hash(auth_hash)
    sign_in user
    fallback = user.projects.any? ? projects_path : new_project_path
    redirect_back_or_default(fallback)
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
