FROM ruby:2.1

# PID 1 needs to handle process reaping and signals
# https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
RUN curl -L https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 > /usr/local/bin/dumb-init && chmod +x /usr/local/bin/dumb-init

RUN mkdir -p /az_sidekiq_web
WORKDIR /az_sidekiq_web

COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler \
    && bundle config git.allow_insecure true \
    && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
