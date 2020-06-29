FactoryBot.define do
  factory :scraper do
    name { Faker::TvShows::GameOfThrones.character }
    description { Faker::TvShows::GameOfThrones.quote }
  end
end
