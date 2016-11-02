FROM ruby:2.3-slim
MAINTAINER WPScan Team <team@wpscan.org>

RUN DEBIAN_FRONTEND=noninteractive && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get update && \
  apt-get --no-install-recommends -qq -y install curl git ca-certificates openssl libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev build-essential procps

RUN useradd -d /wpscan wpscan
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc
RUN mkdir /wpscan

COPY . /wpscan

WORKDIR /wpscan

RUN bundle install --without test
RUN chown -R wpscan:wpscan /wpscan

USER wpscan
RUN /wpscan/wpscan.rb --update --verbose --no-color

ENTRYPOINT ["/wpscan/wpscan.rb"]
CMD ["--help"]
