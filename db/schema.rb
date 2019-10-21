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

ActiveRecord::Schema.define(version: 2019_10_20_232233) do

  create_table "common_names", force: :cascade do |t|
    t.string "name"
    t.integer "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_common_names_on_plant_id"
  end

  create_table "cultivators", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "species_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species_id"], name: "index_cultivators_on_species_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "common_name"
    t.integer "genus_id"
    t.integer "kingdom_id"
    t.index ["genus_id"], name: "index_divisions_on_genus_id"
    t.index ["kingdom_id"], name: "index_divisions_on_kingdom_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["order_id"], name: "index_families_on_order_id"
  end

  create_table "genus", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "family_id"
    t.index ["family_id"], name: "index_genus_on_family_id"
  end

  create_table "high_level_locations", force: :cascade do |t|
    t.string "name"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "long"
    t.decimal "lat"
    t.integer "user_id"
    t.index ["user_id"], name: "index_high_level_locations_on_user_id"
  end

  create_table "kingdoms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "common_name"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.boolean "indoors"
    t.integer "high_level_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["high_level_location_id"], name: "index_locations_on_high_level_location_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "class_id"
    t.integer "plant_class_id"
    t.index ["class_id"], name: "index_orders_on_class_id"
    t.index ["plant_class_id"], name: "index_orders_on_plant_class_id"
  end

  create_table "plant_classes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "division_id"
    t.index ["division_id"], name: "index_plant_classes_on_division_id"
  end

  create_table "plant_instances", force: :cascade do |t|
    t.integer "plant_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "planted_date"
    t.date "acquired_date"
    t.integer "propagation_type"
    t.index ["location_id"], name: "index_plant_instances_on_location_id"
    t.index ["plant_id"], name: "index_plant_instances_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.integer "kingdom_id"
    t.integer "division_id"
    t.integer "plant_class_id"
    t.integer "order_id"
    t.integer "family_id"
    t.integer "genus_id"
    t.integer "species_id"
    t.integer "variety_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cultivator_id"
    t.string "image_url"
    t.index ["cultivator_id"], name: "index_plants_on_cultivator_id"
    t.index ["division_id"], name: "index_plants_on_division_id"
    t.index ["family_id"], name: "index_plants_on_family_id"
    t.index ["genus_id"], name: "index_plants_on_genus_id"
    t.index ["kingdom_id"], name: "index_plants_on_kingdom_id"
    t.index ["order_id"], name: "index_plants_on_order_id"
    t.index ["plant_class_id"], name: "index_plants_on_plant_class_id"
    t.index ["species_id"], name: "index_plants_on_species_id"
    t.index ["variety_id"], name: "index_plants_on_variety_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "genus_id"
    t.index ["genus_id"], name: "index_species_on_genus_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "varieties", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "water_records", force: :cascade do |t|
    t.integer "plant_instance_id"
    t.datetime "moment"
    t.decimal "ounces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_instance_id"], name: "index_water_records_on_plant_instance_id"
  end

  create_table "weather_records", force: :cascade do |t|
    t.date "date"
    t.text "report"
    t.integer "high_level_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["high_level_location_id"], name: "index_weather_records_on_high_level_location_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_wishlists_on_plant_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

end
