class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.string :recipient_email

      t.timestamps
    end
  end
end
