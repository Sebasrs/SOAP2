# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "clients", primary_key: "idClient", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "fName", limit: 45, null: false
    t.string "lName", limit: 45, null: false
    t.string "address", limit: 45, null: false
    t.string "identification", limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "enabled", null: false
  end

  create_table "countries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", primary_key: "idProvince", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.integer "Country_idCountry", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["Country_idCountry"], name: "fk_Province_Country1_idx"
  end

  create_table "restaurants", primary_key: "idRestaurant", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.string "address", limit: 45, null: false
    t.string "contactNumber", limit: 45, null: false
    t.string "disponibilityDays", limit: 45, null: false
    t.string "disponibilityHours", limit: 45, null: false
    t.integer "Province_idProvince", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["Province_idProvince"], name: "fk_Restaurant_Province1_idx"
  end

  create_table "users", primary_key: "idUser", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "userName", limit: 45, null: false
    t.string "password", limit: 45, null: false
    t.integer "Client_idClient", null: false
    t.integer "Restaurant_idRestaurant", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "enabled", null: false
    t.index ["Client_idClient"], name: "fk_User_Client1_idx"
    t.index ["Restaurant_idRestaurant"], name: "fk_User_Restaurant1_idx"
  end

  add_foreign_key "provinces", "countries", column: "Country_idCountry", name: "fk_Province_Country1"
  add_foreign_key "restaurants", "provinces", column: "Province_idProvince", primary_key: "idProvince", name: "fk_Restaurant_Province1"
  add_foreign_key "users", "clients", column: "Client_idClient", primary_key: "idClient", name: "fk_User_Client1"
  add_foreign_key "users", "restaurants", column: "Restaurant_idRestaurant", primary_key: "idRestaurant", name: "fk_User_Restaurant1"
end
