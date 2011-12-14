class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html
  
  expose(:projects) do
    case action_name
    when 'mine'
      current_user.projects
    else
      Project.scoped
    end
  end
  
  expose(:project)
  
  def create
    project.save
    respond_with project
  end
  
end
