FROM ruby:2.5-alpine
LABEL maintainer="WPScan Team <team@wpscan.org>"

ARG BUNDLER_ARGS="--jobs=8 --without test"

# Add a new user
RUN adduser -h /wpscan -g WPScan -D wpscan

# Setup gems
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc

COPY Gemfile /wpscan
COPY Gemfile.lock /wpscan

# Runtime dependencies
RUN apk add --no-cache libcurl procps && \
  # build dependencies
  apk add --no-cache --virtual build-deps alpine-sdk ruby-dev libffi-dev zlib-dev && \
  bundle install --system --gemfile=/wpscan/Gemfile $BUNDLER_ARGS && \
  apk del --no-cache build-deps

# Copy over data & set permissions
COPY . /wpscan
RUN chown -R wpscan:wpscan /wpscan

# Switch directory
WORKDIR /wpscan

# Switch users
USER wpscan

# Update WPScan
RUN /wpscan/wpscan.rb --update --verbose --no-color

# Run WPScan
ENTRYPOINT ["/wpscan/wpscan.rb"]
CMD ["--help"]
