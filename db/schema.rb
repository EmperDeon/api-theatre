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

ActiveRecord::Schema.define(version: 20170423161223) do

  create_table "actors", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "theatre_id"
    t.string "name"
    t.text "desc"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["theatre_id"], name: "fk_rails_1111cf655a"
  end

  create_table "actors_t_performances", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "t_performance_id", null: false
    t.bigint "actor_id", null: false
    t.index ["t_performance_id", "actor_id"], name: "index_actors_t_performances_on_t_performance_id_and_actor_id", unique: true
  end

  create_table "articles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "theatre_id"
    t.string "name"
    t.string "img"
    t.text "desc"
    t.text "desc_s"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["theatre_id"], name: "fk_rails_57adbfb39c"
  end

  create_table "comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "u_web_id"
    t.text "content"
    t.integer "rating"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["u_web_id"], name: "index_comments_on_u_web_id"
  end

  create_table "favorites", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "u_web_id"
    t.integer "t_perf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["t_perf_id"], name: "fk_rails_9b13374290"
    t.index ["u_web_id"], name: "index_favorites_on_u_web_id"
  end

  create_table "galleries", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "t_perf_id"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["t_perf_id"], name: "fk_rails_243c8db3df"
  end

  create_table "p_types", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "performances", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "p_type_id"
    t.string "name"
    t.string "author"
    t.integer "approved", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["p_type_id"], name: "fk_rails_9c1fd40ba9"
  end

  create_table "posters", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "t_perf_id"
    t.datetime "date"
    t.text "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["t_perf_id"], name: "fk_rails_b667d2586f"
  end

  create_table "seats", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "poster_id"
    t.string "seat"
    t.float "price", limit: 24
    t.boolean "sell", default: false
    t.index ["poster_id"], name: "index_seats_on_poster_id"
  end

  create_table "t_halls", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "theatre_id"
    t.string "name"
    t.text "json"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["theatre_id"], name: "fk_rails_075382ab4b"
  end

  create_table "t_performances", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "theatre_id"
    t.integer "t_hall_id"
    t.integer "perf_id"
    t.string "img"
    t.text "desc_s"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["perf_id"], name: "fk_rails_15a6bde515"
    t.index ["t_hall_id"], name: "fk_rails_2983b217d0"
    t.index ["theatre_id"], name: "fk_rails_eb58e15077"
  end

  create_table "theatres", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "tickets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "u_web_id"
    t.integer "seat_id"
    t.string "ticket"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seat_id"], name: "index_tickets_on_seat_id"
    t.index ["u_web_id"], name: "index_tickets_on_u_web_id"
  end

  create_table "u_apis", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.index ["theatre_id"], name: "fk_rails_7fff8de84e"
  end

  create_table "u_apis_perms", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "u_api_id", null: false
    t.bigint "u_perm_id", null: false
  end

  create_table "u_perms", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "perm"
  end

  create_table "u_webs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "login", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.string "fio"
    t.string "tel_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["login"], name: "index_u_webs_on_login", unique: true
  end

  add_foreign_key "actors", "theatres"
  add_foreign_key "articles", "theatres"
  add_foreign_key "comments", "u_webs"
  add_foreign_key "favorites", "t_performances", column: "t_perf_id"
  add_foreign_key "favorites", "u_webs"
  add_foreign_key "galleries", "t_performances", column: "t_perf_id"
  add_foreign_key "performances", "p_types"
  add_foreign_key "posters", "t_performances", column: "t_perf_id"
  add_foreign_key "seats", "posters"
  add_foreign_key "t_halls", "theatres"
  add_foreign_key "t_performances", "performances", column: "perf_id"
  add_foreign_key "t_performances", "t_halls"
  add_foreign_key "t_performances", "theatres"
  add_foreign_key "tickets", "seats"
  add_foreign_key "tickets", "u_webs"
  add_foreign_key "u_apis", "theatres"
end
