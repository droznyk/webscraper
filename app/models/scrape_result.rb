class ScrapeResult < ApplicationRecord
  belongs_to :ruleset
  delegate :name, :description, to: :ruleset
end
