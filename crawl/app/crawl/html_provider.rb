require 'open-uri'
require 'watir-webdriver'

class HtmlProvider
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def get()
    #TODO: error handling
    browser = Watir::Browser.new(:phantomjs)
    browser.goto(@url)
    browser.html
  end
end
