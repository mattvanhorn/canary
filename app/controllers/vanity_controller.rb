# provides the vanity dashboard
# /vanity(/:action(/:id(.:format))) {:controller=>"vanity"}
class VanityController < ApplicationController
  include Vanity::Rails::Dashboard
end