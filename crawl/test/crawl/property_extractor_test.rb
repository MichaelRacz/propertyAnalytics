require 'test_helper'
require File.expand_path('../../../app/crawl/property_extractor', __FILE__)

class PropertyExtractorTest < ActiveSupport::TestCase
  test 'properties are extracted' do
    extractor = PropertyExtractor.new

    html = Nokogiri::HTML(%Q{<html><body>
<section>
  <div class="description">a</div>
  <div class="rent">1</div>
  <div class="squareMetres">2</div>
</section>
<section>
  <div class="description">b</div>
  <div class="rent">3</div>
  <div class="squareMetres">4</div>
</section></body></html>})

    properties = extractor.extract(html)
    
    property1 = properties[0]
    assert_equal "a", property1[:description]
    assert_equal "1", property1[:rent]
    assert_equal "2", property1[:squareMetres]

    property2 = properties[1]
    assert_equal "b", property2[:description]
    assert_equal "3", property2[:rent]
    assert_equal "4", property2[:squareMetres]
  end

  test 'single property is extracted' do
    extractor = PropertyExtractor.new

    html = Nokogiri::HTML(%Q{<html><body>
<section>
  <div class="description">a</div>
  <div class="rent">1</div>
  <div class="squareMetres">2</div>
</section>
</body></html>})

    properties = extractor.extract(html)
    
    property1 = properties[0]
    assert_equal "a", property1[:description]
    assert_equal "1", property1[:rent]
    assert_equal "2", property1[:squareMetres]
  end

  test 'elements in between are ignored' do
    extractor = PropertyExtractor.new

    html = Nokogiri::HTML(%Q{<html><body>
<div>
<section>
  <div class="intermediate">
    <div class="description">a</div>
    <div class="rent">1</div>
    <div class="squareMetres">2</div>
  </div>
</section>
</div>
</body></html>})

    properties = extractor.extract(html)
    
    property1 = properties[0]
    assert_equal "a", property1[:description]
    assert_equal "1", property1[:rent]
    assert_equal "2", property1[:squareMetres]
  end
end
