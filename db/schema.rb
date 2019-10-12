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

ActiveRecord::Schema.define(version: 20191012211131) do

  create_table "clients", force: :cascade do |t|
    t.text "firstname"
    t.text "lastname"
    t.text "email"
  end

  create_table "photographers", force: :cascade do |t|
    t.text "firstname"
    t.text "lastname"
    t.text "username"
    t.text "email"
    t.text "password_digest"
  end

  create_table "sessions", force: :cascade do |t|
    t.text     "type"
    t.integer  "price"
    t.datetime "date"
    t.integer  "photographer_id"
    t.integer  "client_id"
    t.integer  "duration"
    t.integer  "rating"
  end

end
