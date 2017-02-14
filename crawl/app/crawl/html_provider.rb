require 'open-uri'

class HtmlProvider
  def get(url)
    #TODO: error handling
    Nokogiri::HTML(open(url))
  end
end
