FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs nodejs-legacy npm bzip2
RUN npm install -g phantomjs-prebuilt
RUN mkdir /crawl
COPY . /crawl
WORKDIR /crawl
RUN bundle install

CMD ["rails", "server"]

EXPOSE 3000
