# Property analytics

Property analytics is system of microservices dealing with properties/real web sites. 

It consists of the following components:
  * statistics: Provides an API to CRUD and query property data and is the centerpiece of the system. The purpose of the app is to get familiar with Phoenix/Elixir/Ecto ... 
  * ui: This is just a static property site to provide a source for the crawl component. Used technologies include NodeJS and ReactJS.
  * crawl: A little service to crawl the sample site using PhantomJS, Watir, Nokogiri
  * deploy: Two shell scripts to (un)deploy the components with docker. The scripts include handling of the network, images and containers.

Further information can be found in the README.md file of the respective component.
