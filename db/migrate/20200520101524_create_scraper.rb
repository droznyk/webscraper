class CreateScraper < ActiveRecord::Migration[6.0]
  def change
    create_table :scrapers do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
