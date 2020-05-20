class Ruleset < ApplicationRecord
  belongs_to :scraper
  has_many :scrape_results, dependent: :destroy

  validates_presence_of :name, :url, :parent_rule, :parent_rule_is_xpath
  validates_inclusion_of :parent_rule_is_xpath, in: [true, false]

  def has_child_rule?
    self.child_rule.present?
  end
end
