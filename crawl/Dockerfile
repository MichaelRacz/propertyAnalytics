FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /crawl
COPY . /crawl
WORKDIR /crawl
RUN bundle install

CMD ["rails", "server"]

EXPOSE 3000
