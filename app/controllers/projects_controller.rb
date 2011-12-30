class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  autocomplete :company, :name, :full => true

  respond_to :html

  expose(:company) { Company.find_by_id(params[:company_id]) if params[:company_id].present? }

  expose(:projects) do
    if company
      company.projects
    else
      Project.scoped
    end
  end

  expose(:project)

  def index
    # view only
  end

  def show
    # view only
  end

  def new
    # view only
  end

  def create
    if current_user.join(project)
      redirect_to project_url(project)
    else
      render :new
    end
  end


end
