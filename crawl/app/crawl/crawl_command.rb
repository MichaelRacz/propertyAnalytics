class CrawlCommand
  attr_accessor :html_provider, :property_extractor

  def initialize(html_provider, property_extractor)
    @html_provider = html_provider
    @property_extractor = property_extractor
  end

  def execute()
    html = @html_provider.get()
    properties = @property_extractor.extract(html)
    {:properties => properties}
  end
end
