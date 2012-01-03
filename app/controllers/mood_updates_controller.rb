# Processes user updates to their mood wrt a project
#    project_mood_updates GET  /projects/:project_id/mood_updates(.:format)     {:action=>"index", :controller=>"mood_updates"}
#                         POST /projects/:project_id/mood_updates(.:format)     {:action=>"create", :controller=>"mood_updates"}
# new_project_mood_update GET  /projects/:project_id/mood_updates/new(.:format) {:action=>"new", :controller=>"mood_updates"}

class MoodUpdatesController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  expose(:project)
  expose(:mood_updates){ project.mood_updates }
  expose(:mood_update)

  def index
    # view only
  end

  def new
    # view only
  end

  def create
    my_project = project
    current_user.update_mood_for_project(my_project, mood_update)
    redirect_to my_project
  end

end