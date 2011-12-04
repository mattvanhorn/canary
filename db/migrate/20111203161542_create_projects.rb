class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name

      t.timestamps
    end
    add_index :projects, :name, :unique => true
    
    create_table :memberships do |t|
      t.integer :project_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
