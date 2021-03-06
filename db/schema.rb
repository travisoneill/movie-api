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

ActiveRecord::Schema.define(version: 20170216235738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_ratings", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "movie_id",   null: false
    t.integer  "rating",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_ratings_on_movie_id", using: :btree
    t.index ["user_id"], name: "index_movie_ratings_on_user_id", using: :btree
  end

  create_table "movie_relationships", force: :cascade do |t|
    t.integer  "movie_id1",  null: false
    t.integer  "movie_id2",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id2", "movie_id1"], name: "index_movie_relationships_on_movie_id2_and_movie_id1", using: :btree
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title",       null: false
    t.string   "description"
    t.integer  "year"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["title"], name: "index_movies_on_title", unique: true, using: :btree
    t.index ["year"], name: "index_movies_on_year", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "session"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["session"], name: "index_users_on_session", unique: true, using: :btree
  end

end
