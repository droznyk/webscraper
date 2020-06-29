require 'rails_helper'

RSpec.describe ScrapeResult, type: :model do
  subject { build :scrape_result }

  it 'delegates name to ruleset' do
    expect(subject.name).to eq subject.ruleset.name
  end

  it 'delegates description to ruleset' do
    expect(subject.description).to eq subject.ruleset.description
  end

  describe 'associations' do
    it { is_expected.to belong_to :ruleset }
  end
end
