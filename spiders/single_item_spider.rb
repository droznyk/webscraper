class SingleItemSpider < ApplicationSpider
  @name = 'single_item_spider'

  def self.process(ruleset)
    @start_urls = [ruleset[:url]]
    @@ruleset = ruleset
    crawl!
  end

  def parse(response, url:, data: {})
    item = if @@ruleset.child.present?
      response.public_send(@@ruleset.method, @@ruleset.rule).each do |element|
        element.public_send(@@ruleset.child[:method], @@ruleset.child[:rule]).text&.squish
      end
    else
      response.public_send(@@ruleset.method, @@ruleset.rule).text&.squish
    end

    ScrapeResult.create(ruleset_id: @@ruleset.id, result_value: item)
  end
end
