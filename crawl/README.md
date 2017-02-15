# Crawl

This is a tiny web app to crawl properties/real web sites. 

The purpose of this app is to find out how much code is needed to run a simple web crawler with ruby.

The used frameworks/applications/libraries include:
  * Grape
  * PhantomJS
  * Watir
  * Nokogiri

There is only one web method which starts a crawl: [`localhost:3000/crawl?url=<url_to_crawl>`](localhost:3000/crawl?url=<url_to_crawl>). The static site of the ui component can be crawled by passing `localhost:8080` as the <url_to_crawl> when it is hosted locally.

## To start your Phoenix app:

  * Install dependencies with `bundle install`
  * Start the server with `rails server`
