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

ActiveRecord::Schema.define(version: 20140912121150) do

  create_table "articles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "sentence_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["sentence_id"], name: "index_comments_on_sentence_id"

  create_table "sentences", force: true do |t|
    t.text     "content"
    t.integer  "article_id"
    t.integer  "paragraph"
    t.integer  "position"
    t.string   "end_symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sentences", ["article_id"], name: "index_sentences_on_article_id"

end
