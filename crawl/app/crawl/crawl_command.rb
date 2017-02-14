class CrawlCommand
  attr_accessor :url, :htmlProvider, :propertyExtractor

  def initialize(url, htmlProvider, propertyExtractor)
    @url = url
    @htmlProvider = htmlProvider
    @propertyExtractor = propertyExtractor
  end

  def execute()
    html = @htmlProvider.get(url)
    @propertyExtractor.extract(html)
  end
end
