module API
  class Crawl < Grape::API
    get "crawl" do
      {hello: "world"}
    end
  end
end
