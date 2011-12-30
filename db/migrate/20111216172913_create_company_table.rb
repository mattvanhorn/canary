class CreateCompanyTable < ActiveRecord::Migration
  def change
    create_table :companies, :force => true do |t|
      t.string :name
      t.timestamps
    end
    add_column :projects, :company_id, :integer
    remove_index :projects, :name
    add_index :projects, [:company_id, :name], :unique => true
    add_index :companies, [:name], :unique => true

  end
end