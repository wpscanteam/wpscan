FROM ruby:2.4-alpine
MAINTAINER WPScan Team <team@wpscan.org>

ARG BUNDLER_ARGS="--jobs=8 --without test"

RUN adduser -h /wpscan -g WPScan -D wpscan
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc

COPY Gemfile /wpscan
COPY Gemfile.lock /wpscan

# runtime dependencies
RUN apk add --no-cache libcurl procps && \
  # build dependencies
  apk add --no-cache --virtual build-deps libcurl ruby-dev libffi-dev make gcc musl-dev zlib-dev procps && \
  bundle install --system --gemfile=/wpscan/Gemfile $BUNDLER_ARGS && \
  apk del --no-cache build-deps

COPY . /wpscan
RUN chown -R wpscan:wpscan /wpscan

USER wpscan

RUN /wpscan/wpscan.rb --update --verbose --no-color

ENTRYPOINT ["/wpscan/wpscan.rb"]
CMD ["--help"]
