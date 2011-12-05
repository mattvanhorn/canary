class Membership < ActiveRecord::Base
  belongs_to :project, :inverse_of => :memberships
  belongs_to :user, :inverse_of => :memberships
end
