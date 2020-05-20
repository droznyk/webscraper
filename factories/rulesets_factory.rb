FactoryBot.define do
  factory :ruleset do
    scraper
    name { Faker::Games::Witcher.character }
    description { Faker::Games::Witcher.quote }
    url { 'https://example.com' }
    parent_rule { '//html' }
    parent_rule_is_xpath { true }
    child_rule { 'div.title' }
    child_rule_is_xpath { false }
  end
end
