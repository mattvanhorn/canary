class MergeUserAndIdentity < ActiveRecord::Migration
  def up
    add_column :users, :password_digest, :string
    add_column :users, :email, :string
    drop_table :identities
  end

  def down
  end
end
