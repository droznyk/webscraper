module RulesetsHelper
  def rule_xpath_icon(is_xpath)
    is_xpath ? asset_path('check_circle') : asset_path('x_circle')
  end
end
