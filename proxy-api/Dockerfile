FROM ruby:2.5.1
ENV REDIS_DOCKER_HOST=redis
COPY . /myproxyapi
WORKDIR /myproxyapi
RUN bundle install --without test
CMD ["rails", "server"]