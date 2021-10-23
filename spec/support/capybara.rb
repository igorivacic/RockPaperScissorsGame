require 'capybara/rspec'
require 'webdrivers'
# require 'billy/capybara/rspec'
# Config options: https://peter.sh/experiments/chromium-command-line-switches/
def configure_chrome_driver(app, proxy: false, headless: true)
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { w3c: false },
    loggingPrefs: { browser: 'ALL' }
  )
  window_size = [1920, 1080]
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.read_timeout = 120
  browser_options = ::Selenium::WebDriver::Chrome::Options.new
  browser_options.args << '--headless' if headless
  browser_options.args << '--no-sandbox'
  browser_options.args << '--disable-gpu' if headless
  browser_options.args << '--disable-single-click-autofill'
  browser_options.args << "window-size=#{window_size.join(',')}"
  browser_options.args << '--enable-features=,NetworkServiceInProcess'
  browser_options.args << '--disable-dev-shm-usage'
  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 options: browser_options,
                                 http_client: http_client,
                                 desired_capabilities: caps)
end

Capybara.register_driver :headless_chrome do |app|
  configure_chrome_driver(app, headless: true)
end

JS_DRIVER = (ENV.fetch('WEB_DRIVER') { :headless_chrome }).to_sym

Capybara.javascript_driver = JS_DRIVER
Capybara.default_driver = :rack_test
Capybara.server_port = 8200
Capybara.default_max_wait_time = 15
Capybara.server = :puma, { Silent: true }

RSpec.configure do |config|
  config.before(:each, type: :feature) do |example|
    Capybara.current_driver = JS_DRIVER if example.metadata[:js]
  end

  config.after(:each, type: :feature) do |_example|
    # WebMock.disable_net_connect!(allow_localhost: true)
    Capybara.use_default_driver
  end
end
