class InvitationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  
  respond_to :html
  
  expose(:project)
  expose(:invitations){ project.invitations }
  expose(:invitation)
  
  def create
    recipient = params['invitation']['recipient_email']
    invitation = current_user.invite(recipient).to_join(project)
    
    if invitation.deliver!
      respond_with(project)
    else
      respond_with(project, invitation)
    end
  end

  protected
  
  def projects
    current_user.projects
  end
end
