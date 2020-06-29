require 'rails_helper'

RSpec.describe RulesetsHelper do
  describe '#rule_xpath_icon' do
    it 'returns check_circle when true' do
      allow_any_instance_of(ActionView::Helpers::AssetUrlHelper).to receive(:asset_path)
        .with('check_circle').and_return('check_circle')

      expect(helper.rule_xpath_icon(true)).to eq('check_circle')
    end

    it 'returns x_circle when false' do
      allow_any_instance_of(ActionView::Helpers::AssetUrlHelper).to receive(:asset_path)
        .with('x_circle').and_return('x_circle')

      expect(helper.rule_xpath_icon(false)).to eq('x_circle')
    end
  end
end
