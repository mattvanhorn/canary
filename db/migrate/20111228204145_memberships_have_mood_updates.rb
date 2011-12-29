class MembershipsHaveMoodUpdates < ActiveRecord::Migration
  def self.up
    add_column :mood_updates, :membership_id, :integer
    sql = <<-EOS
      UPDATE mood_updates mu
      SET membership_id = (SELECT id FROM memberships m WHERE m.project_id = mu.project_id AND m.user_id = mu.user_id)
    EOS
    ActiveRecord::Base.connection.execute(sql)
    remove_index :mood_updates, [:project_id, :user_id]
    remove_column :mood_updates, :project_id
    remove_column :mood_updates, :user_id
  end

  def self.down
    add_column :mood_updates, :user_id, :integer
    add_column :mood_updates, :project_id, :integer
    
    sql = <<-EOS
      UPDATE mood_updates mu
      SET (user_id, project_id) = (SELECT m.user_id, m.project_id FROM memberships m WHERE m.id = mu.membership_id)
    EOS
    ActiveRecord::Base.connection.execute(sql)
    add_index :mood_updates, [:project_id, :user_id]
    remove_column :mood_updates, :membership_id
  end
end
