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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160509082408) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "content",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "page_id",     limit: 4
    t.binary   "file",        limit: 65535
    t.string   "filename",    limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "blog_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "comments", ["blog_id"], name: "index_comments_on_blog_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "emails", force: :cascade do |t|
    t.integer  "page_id",     limit: 4
    t.string   "subject",     limit: 255
    t.datetime "receivedate"
    t.string   "messageid",   limit: 255
    t.text     "header",      limit: 65535
    t.text     "body",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "goodjobs", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "task_id",    limit: 4
    t.integer  "number",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "goodjobs", ["task_id"], name: "index_goodjobs_on_task_id", using: :btree
  add_index "goodjobs", ["user_id"], name: "index_goodjobs_on_user_id", using: :btree

  create_table "inquiries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "message",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "project_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "members", ["project_id"], name: "index_members_on_project_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body",            limit: 65535
    t.integer  "conversation_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.boolean  "read",            limit: 1,     default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "sender_id",         limit: 4
    t.integer  "recipient_id",      limit: 4
    t.integer  "comment_id",        limit: 4
    t.boolean  "read",              limit: 1, default: false
    t.integer  "conversation_id",   limit: 4
    t.integer  "message_id",        limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "submit_request_id", limit: 4
  end

  add_index "notifications", ["submit_request_id"], name: "index_notifications_on_submit_request_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "content",     limit: 255
    t.integer  "user_id",     limit: 4,   null: false
    t.integer  "customer_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.integer  "language_id", limit: 4
    t.string   "title",       limit: 255
    t.string   "content",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "questions", ["category_id"], name: "index_questions_on_category_id", using: :btree
  add_index "questions", ["language_id"], name: "index_questions_on_language_id", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "submit_requests", force: :cascade do |t|
    t.integer  "task_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "charge_id",  limit: 4,     null: false
    t.integer  "status",     limit: 4
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "submit_requests", ["task_id"], name: "index_submit_requests_on_task_id", using: :btree
  add_index "submit_requests", ["user_id"], name: "index_submit_requests_on_user_id", using: :btree

  create_table "task_comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "task_id",    limit: 4
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "task_comments", ["task_id"], name: "index_task_comments_on_task_id", using: :btree
  add_index "task_comments", ["user_id"], name: "index_task_comments_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                     null: false
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "deadline"
    t.integer  "charge_id",  limit: 4,                     null: false
    t.boolean  "done",       limit: 1,     default: false
    t.integer  "status",     limit: 4,     default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "project_id", limit: 4
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                   limit: 255
    t.text     "profile",                limit: 65535
    t.string   "uid",                    limit: 255,   default: "", null: false
    t.string   "provider",               limit: 255,   default: "", null: false
    t.string   "provider_name",          limit: 255
    t.string   "image_url",              limit: 255
    t.string   "image",                  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "comments", "blogs"
  add_foreign_key "comments", "users"
  add_foreign_key "goodjobs", "tasks"
  add_foreign_key "goodjobs", "users"
  add_foreign_key "members", "projects"
  add_foreign_key "members", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "submit_requests"
  add_foreign_key "projects", "customers"
  add_foreign_key "projects", "users"
  add_foreign_key "questions", "categories"
  add_foreign_key "questions", "languages"
  add_foreign_key "questions", "users"
  add_foreign_key "submit_requests", "tasks"
  add_foreign_key "submit_requests", "users"
  add_foreign_key "task_comments", "tasks"
  add_foreign_key "task_comments", "users"
  add_foreign_key "tasks", "users"
end
