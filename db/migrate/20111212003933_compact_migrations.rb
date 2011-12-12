class CompactMigrations < ActiveRecord::Migration
  def change
    create_table "invitations", :force => true do |t|
      t.integer  "user_id"
      t.integer  "project_id"
      t.string   "recipient_email"
      t.string   "token"
      t.string   "state"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "invitations", ["token"], :name => "index_invitations_on_token", :unique => true

    create_table "memberships", :force => true do |t|
      t.integer  "project_id"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "mood_updates", :force => true do |t|
      t.integer  "project_id"
      t.integer  "user_id"
      t.integer  "mood_score"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "projects", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "projects", ["name"], :name => "index_projects_on_name", :unique => true

    create_table "users", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "password_digest"
      t.string   "email"
    end
  end
end
