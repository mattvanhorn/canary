class AddCommentToMoodUpdateTable < ActiveRecord::Migration
  def change
    add_column :mood_updates, :comment, :string
  end
end
