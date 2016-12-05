FROM ruby:2

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install

ADD . .
EXPOSE 4567
CMD ["bundle", "exec", "middleman", "server"]
