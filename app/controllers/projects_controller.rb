class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :company, :name, :full => true
  
  respond_to :html
  expose(:company){ Company.find_by_id(params[:company_id]) }
  expose(:projects) do
    if company
      company.projects
    else
      Project.scoped
    end
  end
  
  expose(:project)
  
  def create
    if current_user.join(project)
      redirect_to my_projects_url
    else
      render :action => 'new'
    end
  end
  
end
