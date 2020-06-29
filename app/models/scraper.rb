class Scraper < ApplicationRecord
  has_many :rulesets, dependent: :destroy

  validates_presence_of :name

  scope :by_id, -> { order(:id) }
end
