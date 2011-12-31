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
    redirect_to project_mood_updates_url(my_project.id)
  end

end