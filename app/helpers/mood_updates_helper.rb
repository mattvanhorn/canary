module MoodUpdatesHelper

  def moods_and_mood_scores
     (0..(MoodUpdate::MOODS.size-1)).map{|idx| [MoodUpdate.mood(idx), idx]}
  end

end