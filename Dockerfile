FROM ruby:2.6.3-alpine AS builder
LABEL maintainer="WPScan Team <team@wpscan.org>"

ARG BUNDLER_ARGS="--jobs=8 --without test development"

RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc

COPY . /wpscan

RUN apk add --no-cache git libcurl ruby-dev libffi-dev make gcc musl-dev zlib-dev procps sqlite-dev && \
  bundle install --system --clean --no-cache --gemfile=/wpscan/Gemfile $BUNDLER_ARGS && \
  # temp fix for https://github.com/bundler/bundler/issues/6680
  rm -rf /usr/local/bundle/cache

WORKDIR /wpscan
RUN rake install --trace

# needed so non superusers can read gems
RUN chmod -R a+r /usr/local/bundle


FROM ruby:2.6.3-alpine
LABEL maintainer="WPScan Team <team@wpscan.org>"

RUN adduser -h /wpscan -g WPScan -D wpscan

COPY --from=builder /usr/local/bundle /usr/local/bundle

RUN chown -R wpscan:wpscan /wpscan

# runtime dependencies
RUN apk add --no-cache libcurl procps sqlite-libs

WORKDIR /wpscan

USER wpscan

RUN /usr/local/bundle/bin/wpscan --update --verbose

ENTRYPOINT ["/usr/local/bundle/bin/wpscan"]
