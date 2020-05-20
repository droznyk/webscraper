class AddManualChangeToScrapeResults < ActiveRecord::Migration[6.0]
  def change
    add_column :scrape_results, :manual_change, :boolean, default: false
  end
end
