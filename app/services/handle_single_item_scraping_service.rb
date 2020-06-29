class HandleSingleItemScrapingService
  attr_accessor :prepared_ruleset
  PreparedRuleset = Struct.new(:url, :method, :rule, :child, :id, keyword_init: true)

  def initialize(ruleset)
    prepare_ruleset(ruleset)
  end

  def call
    result = SingleItemSpider.process(prepared_ruleset)
    parse_result(result)
  end

  private

  def prepare_ruleset(ruleset)
    @prepared_ruleset = PreparedRuleset.new(url: ruleset.url, id: ruleset.id)

    if ruleset.parent_rule_is_xpath?
      @prepared_ruleset.method = :xpath
      @prepared_ruleset.rule = ruleset.parent_rule
    else
      @prepared_ruleset.method = :css
      @prepared_ruleset.rule = ruleset.parent_rule
    end

    if ruleset.has_child_rule?
      if ruleset.child_rule_is_xpath?
        @prepared_ruleset.child = { method: :xpath, rule: ruleset.child_rule }
      else
        @prepared_ruleset.child = { method: :css, rule: ruleset.child_rule }
      end
    end
  end

  def parse_result(result)
    if result[:status].to_s == 'completed'
      { success: 'Scraped successfully!' }
    else
      { danger: "Scrape failed! #{result[:error]}" }
    end
  end
end
