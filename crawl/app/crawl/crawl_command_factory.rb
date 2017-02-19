require_relative 'crawl_command'
require_relative 'html_provider'
require_relative 'property_extractor'

class CrawlCommandFactory
  def create_from_url(url)
    CrawlCommand.new(HtmlProvider.new(url), PropertyExtractor.new)
  end

  def create_from_html(html)
    CrawlCommand.new(HtmlContainer.new(html), PropertyExtractor.new)
  end
end
