module ScrapersHelper
  def last_scraped_value(ruleset)
    value = ruleset.scrape_results.last&.result_value
    value ? value : 'N/A'
  end

  def last_scraped_at(ruleset)
    scraped_at = ruleset.scrape_results.last&.created_at
    scraped_at ? scraped_at : 'N/A'
  end
end
