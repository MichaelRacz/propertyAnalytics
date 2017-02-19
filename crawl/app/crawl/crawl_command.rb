class CrawlCommand
  attr_accessor :html_source, :property_extractor

  def initialize(html_source, property_extractor)
    @html_source = html_source
    @property_extractor = property_extractor
  end

  def execute()
    html = @html_source.get
    properties = @property_extractor.extract html
    {:properties => properties}
  end
end
