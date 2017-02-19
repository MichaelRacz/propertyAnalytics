require File.expand_path('../../../crawl/crawl_command_factory', __FILE__)

module API
  class Crawl < Grape::API
    format :json

    params do
      requires :url, type: String, desc: 'url to be crawled'
    end
    get 'crawl' do
      factory = CrawlCommandFactory.new
      command = factory.create_from_url params[:url]
      command.execute
    end

    params do
      requires :html, type: File, desc: 'html file to be crawled'
    end
    post 'crawl' do
      factory = CrawlCommandFactory.new
      html = params[:html].tempfile
      command = factory.create_from_html html
      command.execute
    end
  end
end
