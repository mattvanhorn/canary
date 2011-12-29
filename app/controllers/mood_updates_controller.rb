class MoodUpdatesController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html

  expose(:project)
  expose(:mood_updates){ project.mood_updates }
  expose(:mood_update)
  
  def create
    current_user.update_mood_for_project(project, mood_update)
    redirect_to project_mood_updates_url(project.id)
  end
  
end