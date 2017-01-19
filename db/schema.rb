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

ActiveRecord::Schema.define(version: 20170115164604) do

    create_table "actors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "theatre_id"
        t.string "name"
        t.text "desc", limit: 65535
        t.string "img"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.index ["theatre_id"], name: "fk_rails_1111cf655a", using: :btree
    end

    create_table "actors_t_performances", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "t_performance_id", null: false
        t.integer "actor_id", null: false
    end

    create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "theatre_id"
        t.string "name"
        t.string "img"
        t.text "desc", limit: 65535
        t.text "desc_s", limit: 65535
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.index ["theatre_id"], name: "fk_rails_57adbfb39c", using: :btree
    end

    create_table "p_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.string "name"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
    end

    create_table "performances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "type_id"
        t.string "name"
        t.string "author"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.index ["type_id"], name: "fk_rails_04496abe1c", using: :btree
    end

    create_table "posters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "t_perf_id"
        t.integer "t_hall_id"
        t.datetime "date"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.index ["t_hall_id"], name: "fk_rails_bcdd488789", using: :btree
        t.index ["t_perf_id"], name: "fk_rails_b667d2586f", using: :btree
    end

    create_table "t_halls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "theatre_id"
        t.string "name"
        t.text "json", limit: 65535
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.index ["theatre_id"], name: "fk_rails_075382ab4b", using: :btree
    end

    create_table "t_performances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "theatre_id"
        t.integer "perf_id"
        t.string "img"
        t.string "desc_s"
        t.text "desc", limit: 65535
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.index ["perf_id"], name: "fk_rails_15a6bde515", using: :btree
        t.index ["theatre_id"], name: "fk_rails_eb58e15077", using: :btree
    end

    create_table "theatres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.string "name"
        t.text "desc", limit: 65535
        t.string "img"
        t.string "address"
        t.string "tel_num"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
    end

    create_table "u_apis", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "theatre_id"
        t.string "login"
        t.string "password_digest"
        t.string "fio"
        t.string "tel_num"
        t.string "position"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.index ["theatre_id"], name: "fk_rails_7fff8de84e", using: :btree
    end

    create_table "u_apis_perms", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.integer "u_api_id", null: false
        t.integer "u_perm_id", null: false
    end

    create_table "u_perms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.string "perm"
    end

    create_table "u_webs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        t.string "login"
        t.string "password"
        t.string "fio"
        t.string "tel_num"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
    end

    add_foreign_key "actors", "theatres"
    add_foreign_key "articles", "theatres"
    add_foreign_key "performances", "p_types", column: "type_id"
    add_foreign_key "posters", "t_halls"
    add_foreign_key "posters", "t_performances", column: "t_perf_id"
    add_foreign_key "t_halls", "theatres"
    add_foreign_key "t_performances", "performances", column: "perf_id"
    add_foreign_key "t_performances", "theatres"
    add_foreign_key "u_apis", "theatres"
end
