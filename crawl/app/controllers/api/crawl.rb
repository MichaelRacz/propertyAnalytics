require File.expand_path('../../../crawl/crawl_command_factory', __FILE__)

module API
  class Crawl < Grape::API
    format :json

    params do
      requires :url, type: String, desc: "url to be crawled"
    end
    get "crawl" do
      factory = CrawlCommandFactory.new
      command = factory.create(params[:url])
      command.execute
    end
  end
end
