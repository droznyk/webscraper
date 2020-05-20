class CreateScrapeResults < ActiveRecord::Migration[6.0]
  def change
    create_table :scrape_results do |t|
      t.belongs_to :ruleset
      t.text :result_value

      t.timestamps
    end
  end
end
