# for sending links to 3rd parties, who are not really meant to be invited.
#
# project_links POST /project_links(.:format) {:action=>"create", :controller=>"project_links"}
#
class ProjectLinksController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]

  respond_to :html

  def create
    email = params[:email]
    project = Project.find(params[:project_id])
    if email.present? && project.present?
      InvitationMailer.project_link(email, project).deliver
    end
    redirect_to project
  end

end
