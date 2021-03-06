# for signups
#           sign_up  /sign-up(.:format)                    {:controller=>"registrations", :action=>"new"}
# accept_invitation  /invitations/accept/:token(.:format)  {:controller=>"registrations", :action=>"new"}

class RegistrationsController < ApplicationController
  before_filter :ensure_guest!, :only => [:new]

  expose(:user) { @user }

  def new
    @user = request.env['omniauth.identity'] || User.new
    token = params[:token]
    if token.present?
      invitation = Invitation.for_token(token)
      if invitation
        store_location project_url(invitation.project)
        @user.setup_from_invitation(invitation)
      end
    end
  end

end