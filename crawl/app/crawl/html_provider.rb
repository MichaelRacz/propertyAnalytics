require 'open-uri'
require 'watir-webdriver'

class HtmlProvider
  def get(url)
    #TODO: error handling
    browser = Watir::Browser.new(:phantomjs)
    browser.goto(url)
    Nokogiri::HTML(browser.html)
  end
end
