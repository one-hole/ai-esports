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

ActiveRecord::Schema.define(version: 2018_10_22_114421) do

  create_table "tenants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "expire_time", default: "1970-01-01 00:00:00", comment: "APi 过期时间"
    t.text "public_key", comment: "我们签发的公钥"
    t.text "private_key", comment: "我们签发的私钥"
    t.string "api_key", default: ""
    t.string "api_path", comment: "推送的 APi 路径"
    t.index ["api_key"], name: "key_on_tenants"
  end

end
