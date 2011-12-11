class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user
      t.references :project
      t.string :recipient_email
      t.string :token
      t.string :state
      
      t.timestamps
    end
    add_index :invitations, :token, :unique => true
  end
end
