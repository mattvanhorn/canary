class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html
  
  expose(:projects){ current_user.projects }
  expose(:project)
  
  def create
    project.save
    respond_with project
  end
end
