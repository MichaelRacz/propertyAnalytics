require 'test_helper'
require File.expand_path('../../../app/crawl/crawl_command_factory', __FILE__)

class CrawlCommandTest < ActiveSupport::TestCase
  test 'properties are extracted' do
    factory = CrawlCommandFactory.new

    html = %Q{<html><body>
<section>
  <div class="description">description</div>
  <div class="rent">620</div>
  <div class="squareMetres">75</div>
</section>
</body></html>}

    command = factory.create_from_html(html)
    result = command.execute

    property = result[:properties][0]
    assert_equal "description", property[:description]
    assert_equal "620", property[:rent]
    assert_equal "75", property[:squareMetres]
  end
end
