require 'rails_helper'

RSpec.describe ScrapersHelper do
  describe '#last_scraped_value' do
    context "when ruleset doesn't have scrape results" do
      let(:ruleset) { build :ruleset }

      it "returns 'N/A'" do
        expect(helper.last_scraped_value(ruleset)).to eq('N/A')
      end
    end

    context 'when ruleset have scrape results' do
      let(:scrape_result) { create :scrape_result }

      it 'returns value of scrape_result' do
        ruleset = scrape_result.ruleset

        expect(helper.last_scraped_value(ruleset)).to eq(scrape_result.result_value)
      end
    end
  end

  describe '#last_scraped_at' do
    context "when ruleset doesn't have scrape results" do
      let(:ruleset) { build :ruleset }

      it "returns 'N/A'" do
        expect(helper.last_scraped_at(ruleset)).to eq('N/A')
      end
    end

    context 'when ruleset have scrape results' do
      let(:scrape_result) { create :scrape_result }

      it 'returns created_at of scrape_result' do
        ruleset = scrape_result.ruleset

        expect(helper.last_scraped_at(ruleset)).to eq(scrape_result.created_at)
      end
    end
  end
end
