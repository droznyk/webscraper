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

ActiveRecord::Schema.define(version: 2020_06_18_112956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rulesets", force: :cascade do |t|
    t.bigint "scraper_id"
    t.string "name", null: false
    t.text "description"
    t.string "url", null: false
    t.string "parent_rule"
    t.string "child_rule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "parent_rule_is_xpath"
    t.boolean "child_rule_is_xpath"
    t.index ["scraper_id"], name: "index_rulesets_on_scraper_id"
  end

  create_table "scrape_results", force: :cascade do |t|
    t.bigint "ruleset_id"
    t.text "result_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "manual_change", default: false
    t.index ["ruleset_id"], name: "index_scrape_results_on_ruleset_id"
  end

  create_table "scrapers", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
