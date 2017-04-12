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

ActiveRecord::Schema.define(version: 20170403131042) do

	create_table "actors", force: :cascade do |t|
		t.integer "theatre_id"
		t.string "name"
		t.text "desc"
		t.string "img"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "actors_t_performances", id: false, force: :cascade do |t|
		t.integer "t_performance_id", null: false
		t.integer "actor_id", null: false
		t.index ["t_performance_id", "actor_id"], name: "index_actors_t_performances_on_t_performance_id_and_actor_id", unique: true
	end

	create_table "articles", force: :cascade do |t|
		t.integer "theatre_id"
		t.string "name"
		t.string "img"
		t.text "desc"
		t.text "desc_s"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "comments", force: :cascade do |t|
		t.string "author"
		t.text "content"
		t.integer "rating"
		t.integer "status", default: 0
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "p_types", force: :cascade do |t|
		t.string "name"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "performances", force: :cascade do |t|
		t.integer "p_type_id"
		t.string "name"
		t.string "author"
		t.integer "approved", default: 0
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "posters", force: :cascade do |t|
		t.integer "t_perf_id"
		t.datetime "date"
		t.text "price"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "seats", force: :cascade do |t|
		t.integer "poster_id"
		t.string "seat"
		t.float "price"
		t.boolean "sell"
		t.index ["poster_id"], name: "index_seats_on_poster_id"
	end

	create_table "t_halls", force: :cascade do |t|
		t.integer "theatre_id"
		t.string "name"
		t.text "json"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "t_performances", force: :cascade do |t|
		t.integer "theatre_id"
		t.integer "t_hall_id"
		t.integer "perf_id"
		t.string "img"
		t.string "desc_s"
		t.text "desc"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "theatres", force: :cascade do |t|
		t.string "name"
		t.text "desc"
		t.string "img"
		t.string "address"
		t.string "tel_num"
		t.string "site"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "tickets", force: :cascade do |t|
		t.integer "u_api_id"
		t.integer "poster_id"
		t.string "ticket"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.index ["poster_id"], name: "index_tickets_on_poster_id"
		t.index ["u_api_id"], name: "index_tickets_on_u_api_id"
	end

	create_table "u_apis", force: :cascade do |t|
		t.integer "theatre_id"
		t.string "login"
		t.string "password_digest"
		t.string "fio"
		t.string "tel_num"
		t.string "position"
		t.text "json"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

	create_table "u_apis_perms", id: false, force: :cascade do |t|
		t.integer "u_api_id", null: false
		t.integer "u_perm_id", null: false
	end

	create_table "u_perms", force: :cascade do |t|
		t.string "perm"
	end

	create_table "u_webs", force: :cascade do |t|
		t.string "login"
		t.string "password_digest"
		t.string "fio"
		t.string "tel_num"
		t.datetime "created_at", null: false
		t.datetime "updated_at", null: false
		t.datetime "deleted_at"
	end

end
