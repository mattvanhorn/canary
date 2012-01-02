# most of the work will happen here.
#
# autocomplete_company_name_projects GET  /projects/autocomplete_company_name(.:format) {:action=>"autocomplete_company_name", :controller=>"projects"}
#                           projects GET  /projects(.:format)                           {:action=>"index", :controller=>"projects"}
#                                    POST /projects(.:format)                           {:action=>"create", :controller=>"projects"}
#                        new_project GET  /projects/new(.:format)                       {:action=>"new", :controller=>"projects"}
#                            project GET  /projects/:id(.:format)                       {:action=>"show", :controller=>"projects"}
#                   company_projects GET  /companies/:company_id/projects(.:format)     {:action=>"index", :controller=>"projects"}

class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  autocomplete :company, :name, :full => true

  respond_to :html

  expose(:company) { Company.find_by_id(params[:company_id]) if params[:company_id].present? }

  expose(:projects) do
    if company
      company.projects
    else
      Project.scoped.order('id DESC')
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
    new_project = project
    if current_user.join(new_project)
      redirect_to project_url(new_project)
    else
      render :new
    end
  end


end
