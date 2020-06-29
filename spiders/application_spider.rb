class ApplicationSpider < Kimurai::Base
  @engine = :selenium_chrome
  @config = {
    user_agent: 'Mozilla/5.0 Firefox/61.0 AppleWebKit/537.36 Chrome/68.0.3440.84 Safari/537.36',
    ignore_ssl_errors: true,
    window_size: [1366, 768],
    disable_images: false,
    headless_mode: :native,
    skip_duplicate_requests: true,
    skip_request_errors: [{ error: RuntimeError, message: '404 => Net::HTTPNotFound' }],
    retry_request_errors: [Net::ReadTimeout],
    encoding: :auto,
    restart_if: {
      memory_limit: 850_000,
      requests_limit: 100
    },
    before_request: {
      clear_cookies: true,
      delay: 1..3
    }
  }
end
