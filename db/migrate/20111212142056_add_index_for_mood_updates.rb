class AddIndexForMoodUpdates < ActiveRecord::Migration
  def change
    add_index :mood_updates, [:project_id, :user_id]
  end
end
