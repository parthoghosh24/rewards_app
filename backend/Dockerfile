ARG RUBY_VERSION=3.4.3
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim-bookworm

# app lives here
WORKDIR /app

# Install packages needed to build gems
RUN apt-get update -qq && \
  apt-get install --no-install-recommends -y vim build-essential git libpq-dev libvips pkg-config curl sqlite3 nano libyaml-dev

ARG NODE_VERSION=20.15.0
ARG YARN_VERSION=latest
ENV PATH=/usr/local/node/bin:$PATH

# Run bundle install
COPY Gemfile Gemfile.lock ./
COPY .ruby-version ./
RUN bundle install

# Copy application code
COPY . .

# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]