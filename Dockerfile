# ==============================================================================
# ================================= BUILD STEP =================================
# ==============================================================================
FROM ruby:2.6.2-alpine3.9 AS builder

LABEL version="3.5.5" \
      author="WPScan Team <team@wpscan.org>" \
      docker_build="docker build -t wpscanteam/wpscan:3.5.5 ." \
      docker_run_basic="docker run --rm -ti wpscanteam/wpscan:3.5.5 --url http://www.example.com"

COPY [".", "/wpscan"]

WORKDIR /wpscan

RUN echo 'Selecting packages to WPScan.' \
  && apk update \
  && apk add --no-cache --virtual .build-deps \
     git \
     libcurl \
     ruby-dev \
     libffi-dev \
     make \
     gcc \
     musl-dev \
     zlib-dev \
     procps \
     sqlite-dev \
  && echo 'Cleaning cache from APK.' \
  && rm -rf /var/cache/apk/* \
  && echo 'Disable use the RI or RDoc output from the gems.' \
  && echo "gem: --no-ri --no-rdoc" > /etc/gemrc \
  && echo 'Installing Gemfile.' \
  && export BUNDLER_ARGS="--jobs=8 --without test development" \
  && bundle install \
     --system \
     --clean \
     --no-cache \
     --gemfile=/wpscan/Gemfile \
     $BUNDLER_ARGS \
  && unset BUNDLER_ARGS \
  && echo 'Temp fix for https://github.com/bundler/bundler/issues/6680' \
  && rm -rf /usr/local/bundle/cache \
  && echo 'Rake install process.' \
  && rake install --trace \
  && echo 'Grant non superusers can read gems.' \
  && chmod -R a+r /usr/local/bundle

# ==============================================================================
# ================================= RUNNER STEP ================================
# ==============================================================================

FROM ruby:2.6.2-alpine3.9 AS runner

COPY --from=builder /usr/local/bundle /usr/local/bundle

RUN echo 'Selecting packages to WPScan.' \
  && apk update \
  && apk add --no-cache --virtual .build-deps \
     libcurl \
     procps \
     sqlite-libs \
  && echo 'Cleaning cache from APK.' \
  && rm -rf /var/cache/apk/* \
  && echo 'Creating the wpscan group.' \
  && addgroup wpscan \
  && echo 'Creating the user wpscan.' \
  && adduser -G wpscan -g "wpscan user" -s /bin/sh -D wpscan \
  && echo 'Creating a random password for root.' \
  && export RANDOM_PASSWORD=`tr -dc A-Za-z0-9 < /dev/urandom | head -c44` \
  && echo "root:$RANDOM_PASSWORD" | chpasswd \
  && unset RANDOM_PASSWORD \
  && echo 'Locking root account.' \
  && passwd -l root \
  && echo 'Updating WPScan.' \
  && /usr/local/bundle/bin/wpscan --update --verbose \
  && echo 'Finishing image.'

USER wpscan

ENTRYPOINT ["/usr/local/bundle/bin/wpscan"]
