FROM ruby:2.3.5

ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-development}

# PID 1 needs to handle process reaping and signals
# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN curl -L https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init && chmod +x /usr/local/bin/dumb-init

WORKDIR /az_sidekiq_web

COPY Gemfile Gemfile.lock config.ru ./
RUN gem install bundler \
    && bundle install --jobs 20 --retry 5

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
