# Responsible for showing invitation form and processing send-invitation requests
#
#    project_invitations POST /projects/:project_id/invitations(.:format)      {:action=>"create", :controller=>"invitations"}
# new_project_invitation GET  /projects/:project_id/invitations/new(.:format)  {:action=>"new", :controller=>"invitations"}
#     project_invitation GET  /projects/:project_id/invitations/:id(.:format)  {:action=>"show", :controller=>"invitations"}
class InvitationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  respond_to :html

  expose(:project)
  expose(:invitations){ project.invitations }
  expose(:invitation)

  def new
    # view only
  end

  def show
    # view only
  end

  def create
    my_project = project
    teammate = params['invitation']['recipient_email']
    invitation = current_user.invite(teammate).to_join(my_project)
    if invitation.deliver!
      respond_with(my_project)
    else
      respond_with(my_project, invitation)
    end
  end

  protected

  def projects
    current_user.projects
  end
end
