require_relative 'crawl_command'
require_relative 'html_provider'
require_relative 'property_extractor'

class CrawlCommandFactory
  def create(url)
    CrawlCommand.new(HtmlProvider.new url, PropertyExtractor.new)
  end
end
