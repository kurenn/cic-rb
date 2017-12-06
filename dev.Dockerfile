FROM ruby

RUN mkdir -p /code
WORKDIR /code

ADD . /code

RUN bundle install
