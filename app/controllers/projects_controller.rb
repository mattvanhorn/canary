class ProjectsController < ApplicationController
  respond_to :html
  
  expose(:project)
  expose(:projects){ Project.scoped }
  
  def create
    project.save
    respond_with project
  end
end
