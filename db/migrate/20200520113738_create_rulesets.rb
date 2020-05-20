class CreateRulesets < ActiveRecord::Migration[6.0]
  def change
    create_table :rulesets do |t|
      t.belongs_to :scraper
      t.string :name, null: false
      t.text :description
      t.string :url, null: false
      t.string :selector_type
      t.string :selector_value
      t.string :html_tag

      t.timestamps
    end
  end
end
