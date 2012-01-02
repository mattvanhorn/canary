# Companies controller
# companies GET  /companies(.:format) {:action=>"index", :controller=>"companies"}
class CompaniesController < ApplicationController

  respond_to :html

  expose(:companies){ Company.scoped }
  expose(:company)

  def index
    # view only
  end

end
