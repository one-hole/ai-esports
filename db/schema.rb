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

ActiveRecord::Schema.define(version: 2019_06_12_055433) do

  create_table "dota2_abilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "steam_id", null: false
    t.string "en_name", null: false
    t.string "lg_avatar", default: ""
    t.string "md_avatar", default: ""
    t.string "sm_avatar", default: ""
    t.string "cn_name"
    t.text "desc"
    t.index ["steam_id"], name: "index_steam_on_abilities"
  end

  create_table "dota2_heroes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "steam_id", null: false, comment: "这个 WebAPi 请求的时候返回的英雄 ID、同时也是 YML 里面的 ID"
    t.string "en_name", null: false, comment: "英雄的官方名字"
    t.string "full_avatar", default: "", comment: "英雄full图"
    t.string "lg_avatar", default: "", comment: "英雄lg图"
    t.string "sm_avatar", default: "", comment: "英雄eg图"
    t.string "vert_avatar", default: "", comment: "英雄vert图"
    t.string "cn_name"
    t.string "dac"
    t.string "droles"
    t.index ["steam_id"], name: "index_steam_on_heroes"
  end

  create_table "dota2_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "steam_id", null: false, comment: "物品的 SteamID"
    t.string "en_name", null: false
    t.string "lg_avatar", default: "", comment: "物品eg图"
    t.string "eg_avatar", default: "", comment: "物品lg图"
    t.string "cn_name"
    t.index ["steam_id"], name: "index_steam_on_items"
  end

  create_table "lol_heroes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cn_name"
    t.string "en_name"
    t.string "nick"
    t.integer "offical_id"
    t.integer "attack"
    t.integer "defense"
    t.integer "magic"
    t.integer "difficulty"
  end

  create_table "lol_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hero_id"
    t.string "en_name"
    t.string "cn_name"
    t.text "desc", comment: "技能描述"
    t.string "short", limit: 4, comment: "快捷键"
    t.index ["hero_id", "short"], name: "short_on_skills", unique: true
  end

  create_table "servers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "host"
    t.string "tag"
    t.index ["host", "tenant_id"], name: "idx_host_server"
    t.index ["tenant_id"], name: "index_servers_on_tenant_id"
  end

  create_table "tenants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "expire_time", default: "1970-01-01 00:00:00", comment: "APi 过期时间"
    t.text "public_key", comment: "我们签发的公钥"
    t.text "private_key", comment: "我们签发的私钥"
    t.string "api_key", default: ""
    t.string "api_path", comment: "推送的 APi 路径"
    t.index ["api_key"], name: "key_on_tenants"
  end

end
