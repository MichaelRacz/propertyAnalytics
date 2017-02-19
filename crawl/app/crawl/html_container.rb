class HtmlContainer
  attr_accessor :html

  def initialize(html)
    @html = html
  end

  def get()
    @html
  end
end
