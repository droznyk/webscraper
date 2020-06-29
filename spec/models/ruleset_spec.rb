require 'rails_helper'

RSpec.describe Ruleset, type: :model do
  subject { build :ruleset }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :url }
    it { is_expected.to validate_presence_of :parent_rule }
    it { is_expected.to validate_presence_of :parent_rule_is_xpath }
  end

  describe 'associations' do
    it { is_expected.to belong_to :scraper }
    it { is_expected.to have_many :scrape_results }
  end

  describe '#has_child_rule?' do
    it 'returns true when ruleset has child rule' do
      expect(subject.has_child_rule?).to be_truthy
    end

    it "returns false when ruleset doesn't have child rule" do
      subject.child_rule = ''

      expect(subject.has_child_rule?).to be_falsy
    end
  end
end
