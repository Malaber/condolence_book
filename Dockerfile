FROM ruby:2.6.2-alpine as build
RUN apk --no-cache add build-base tzdata sqlite sqlite-dev postgresql-dev yarn && gem install tzinfo-data
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN yarn install --check-files
RUN bin/rake assets:precompile

FROM ruby:2.6.2-alpine
RUN apk --no-cache add build-base tzdata sqlite sqlite-dev postgresql-dev && gem install tzinfo-data
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --deployment --without development test
COPY . /app
COPY --from=build /app/public /app/public
ENV RAILS_ENV production
CMD bundle exec rails db:migrate && bundle exec rails s -p 3000 -b 0.0.0.0
