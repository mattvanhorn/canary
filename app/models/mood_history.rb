# This class abstracts the idea of 1 update/day/user
class MoodHistory

  def initialize(project, users = nil)
    @history = {}
    @project = project
    @user_ids = screen_users(users).uniq.map(&:id)
    @today = Time.zone.now.beginning_of_day
    @history = populated_history.sort.inject({}) {|hsh,(key,val)| hsh[key]=val; hsh}
  end

  def days
    @history.keys.sort
  end

  def [](datetime)
    @history[datetime.in_time_zone.beginning_of_day]
  end

  alias :on :[]

  def number_of_days
    @history.size
  end

  def avg_mood_score_on(datetime)
    updates = self.on(datetime)
    if updates.any?
      updates.map{|mood_update|mood_update.try(:mood_score)}.compact.sum/@user_ids.size.to_f
    else
      nil
    end
  end

  protected

  def screen_users(users)
    project_users = @project.users
    users_from_project = ((users || project_users) & project_users)
    if users && users.size > users_from_project.size
      warn("#{__FILE__}:#{__LINE__}: user ids: [#{(users - users_from_project).map(&:id).join(', ')}] were not associated with project and were ignored!")
    end
    users_from_project
  end

  def populated_history
    populated = {}
    0.upto(total_days) do |num|
      key = (@today - num.days).in_time_zone
      populated[key] = populate(key)
    end
    populated
  end

  def total_days
    ((@today - first_day)/ 1.day).ceil
  end

  def first_day
    raw_data.keys.first || @today
  end

  def raw_data
    @raw_data ||= MoodUpdate.for_project(@project).chronological.group_by{|mu| mu.date }
  end

  def populate(date)
    if raw_data[date].present?
      return @user_ids.collect{|uid| populate_for_user_on_date(uid, date) }
    end

    return ([nil] * @user_ids.size)
  end

  def populate_for_user_on_date(uid, date)
    raw_data[date].select{|mu|mu.user.id == uid}.last
  end
end