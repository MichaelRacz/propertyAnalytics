class PropertyExtractor
  def extract(html)
    html.css("h6").text
  end
end
