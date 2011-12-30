# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111230200612) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name"], :name => "index_companies_on_name", :unique => true

  create_table "invitations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "recipient_email"
    t.string   "token"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["project_id"], :name => "index_invitations_on_project_id"
  add_index "invitations", ["token"], :name => "index_invitations_on_token", :unique => true
  add_index "invitations", ["user_id"], :name => "index_invitations_on_user_id"

  create_table "memberships", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["project_id"], :name => "index_memberships_on_project_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "mood_updates", :force => true do |t|
    t.integer  "mood_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "membership_id"
  end

  add_index "mood_updates", ["membership_id"], :name => "index_mood_updates_on_membership_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  add_index "projects", ["company_id", "name"], :name => "index_projects_on_company_id_and_name", :unique => true
  add_index "projects", ["company_id"], :name => "index_projects_on_company_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
