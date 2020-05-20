require 'rails_helper'

RSpec.describe Scraper, type: :model do
  subject { build :scraper }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'associations' do
    it { is_expected.to have_many :rulesets }

    context 'on scraper destroy' do
      before { create :scrape_result }

      it 'destroys scraper with rulesets and scrape results' do
        expect(Scraper.count).to eq(1)
        expect(Ruleset.count).to eq(1)
        expect(ScrapeResult.count).to eq(1)

        Scraper.last.destroy

        expect(Scraper.count).to eq(0)
        expect(Ruleset.count).to eq(0)
        expect(ScrapeResult.count).to eq(0)
      end
    end
  end
end
