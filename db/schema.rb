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

ActiveRecord::Schema.define(version: 2021_04_21_034810) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bbch_profiles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bbch_stages", force: :cascade do |t|
    t.integer "code"
    t.string "description"
    t.string "note"
    t.integer "bbch_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bbch_profile_id"], name: "index_bbch_stages_on_bbch_profile_id"
  end

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
    t.integer "kingdom_id"
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

  create_table "growth_observations", force: :cascade do |t|
    t.integer "plant_instance_id"
    t.date "observation_date"
    t.integer "bbch_stage_id"
    t.integer "percent_at_stage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bbch_stage_id"], name: "index_growth_observations_on_bbch_stage_id"
    t.index ["plant_instance_id"], name: "index_growth_observations_on_plant_instance_id"
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
    t.integer "plant_class_id"
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
    t.date "sprout_date"
    t.string "reference_name"
    t.index ["location_id"], name: "index_plant_instances_on_location_id"
    t.index ["plant_id"], name: "index_plant_instances_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.integer "species_id"
    t.integer "variety_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cultivator_id"
    t.string "image_url"
    t.string "OpenFarmID"
    t.index ["cultivator_id"], name: "index_plants_on_cultivator_id"
    t.index ["species_id"], name: "index_plants_on_species_id"
    t.index ["variety_id"], name: "index_plants_on_variety_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "genus_id"
    t.integer "bbch_profile_id"
    t.index ["bbch_profile_id"], name: "index_species_on_bbch_profile_id"
    t.index ["genus_id"], name: "index_species_on_genus_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "high_level_location_id"
    t.index ["high_level_location_id"], name: "index_users_on_high_level_location_id"
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

  create_table "weather_averages", force: :cascade do |t|
    t.integer "day"
    t.integer "high_level_location_id"
    t.decimal "max_temp_f"
    t.decimal "min_temp_f"
    t.decimal "precip_in"
    t.decimal "max_t_std_dev"
    t.decimal "min_t_std_dev"
    t.decimal "precip_std_dev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["high_level_location_id"], name: "index_weather_averages_on_high_level_location_id"
  end

  create_table "weather_records", force: :cascade do |t|
    t.date "date"
    t.text "report"
    t.integer "high_level_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "min_temp_f"
    t.decimal "max_temp_f"
    t.decimal "precip_in"
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
