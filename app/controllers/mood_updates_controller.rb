class MoodUpdatesController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html

  expose(:project)
  expose(:mood_updates){ project.mood_updates }
  expose(:mood_update)
  
  def create
    current_user.mood_updates << mood_update
    redirect_to project_mood_updates_url(project)
  end
  
end