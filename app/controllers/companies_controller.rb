class CompaniesController < ApplicationController
  
  respond_to :html
  
  expose(:companies){ Company.scoped }
  expose(:company)
  
end
