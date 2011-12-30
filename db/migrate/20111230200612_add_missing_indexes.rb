class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :invitations, :project_id
    add_index :invitations, :user_id
    add_index :memberships, :project_id
    add_index :memberships, :user_id
    add_index :mood_updates, :membership_id
    add_index :projects, :company_id
    add_index :users, :email
  end
end
