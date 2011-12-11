class CreateMoodUpdates < ActiveRecord::Migration
  def change
    create_table :mood_updates do |t|
      t.references :project
      t.references :user
      t.integer :mood_score

      t.timestamps
    end
  end
end
