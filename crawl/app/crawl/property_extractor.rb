class PropertyExtractor
  def extract(html)
    html = Nokogiri::HTML(html)
    sections = html.css('section')
    properties = Array.new

    sections.each do |section|
      properties << {
        :description => section.at_css('div.description').text,
        :rent => section.at_css('div.rent').text,
        :squareMetres => section.at_css('div.squareMetres').text
      }
    end

    properties
  end
end
