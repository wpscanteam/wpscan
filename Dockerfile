FROM alpine:3.4
MAINTAINER WPScan Team <team@wpscan.org>

RUN mkdir /wpscan
WORKDIR /wpscan

RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc
COPY Gemfile /wpscan

RUN apk add --no-cache ruby libcurl ruby-dev ruby-bundler libffi-dev make gcc musl-dev zlib-dev procps && \
  bundle install --without test && \
  apk del --purge ruby-dev libffi-dev make gcc musl-dev zlib-dev

COPY . /wpscan
RUN /wpscan/wpscan.rb --update --verbose --no-color

ENTRYPOINT ["/wpscan/wpscan.rb"]
CMD ["--help"]
