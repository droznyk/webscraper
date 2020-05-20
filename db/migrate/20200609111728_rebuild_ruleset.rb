class RebuildRuleset < ActiveRecord::Migration[6.0]
  def change
    rename_column :rulesets, :selector_type, :parent_rule
    rename_column :rulesets, :selector_value, :child_rule

    add_column :rulesets, :parent_rule_is_xpath, :boolean
    add_column :rulesets, :child_rule_is_xpath, :boolean

    remove_column :rulesets, :html_tag
  end
end
