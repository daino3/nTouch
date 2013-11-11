require "json"
require "selenium-webdriver"
require "rspec"
require "selenium-client"
include RSpec::Expectations

describe "SeleniumTest" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:3000/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_selenium" do
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "fb_sign_in").click
    @driver.find_element(:link, "User Profile").click
    @driver.find_element(:link, "Manage Friends").click
    @driver.find_element(:link, "NTOUCH").click
    @driver.find_element(:link, "Manage Events").click
    @driver.find_element(:link, "NTOUCH").click
    @driver.find_element(:css, "img[alt=\"70595 2258832 7810249 q\"]").click
    @driver.find_element(:link, "Manage Friends").click
    @driver.find_element(:css, "div > #nav > #company_logo > h1 > a").click
    @driver.find_element(:id, "logout").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
